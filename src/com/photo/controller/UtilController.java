package com.photo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class UtilController {

    //跳转至登陆界面
    @RequestMapping("toLogin")
    public String toLogin(HttpSession session) {
        session.invalidate();
        return "views/login";
    }


    @RequestMapping("toLoginOutAct")
    public String toLoginOutAct(HttpSession session) {
        session.invalidate();
        return "views/login";
    }

    @RequestMapping("toRegister")
    public String toRegister(HttpSession session) {
        session.invalidate();
        return "views/user/register";
    }
    //跳转到控制页console.jsp
    @RequestMapping("toConsoleAct")
    public String toWelocmeAct() {
        return "views/console";
    }

    @RequestMapping("toMain")
    public String toMain(HttpServletRequest request) {
        return "views/main";
    }


    @RequestMapping("toEcharts")
    public String toEcharts(HttpServletRequest request) {
        return "views/echarts";
    }


    //图片上传测试
    @ResponseBody
    @RequestMapping("/upload")
    public Map upload2(MultipartFile file, HttpServletRequest request){

        String prefix="";
        String dateStr="";
        //保存上传
        OutputStream out = null;
        InputStream fileInput=null;
        try{
            if(file!=null){
                String originalName = file.getOriginalFilename();
                prefix=originalName.substring(originalName.lastIndexOf(".")+1);
                Date date = new Date();
                String uuid = UUID.randomUUID()+"";
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                dateStr = simpleDateFormat.format(date);
                String filepath = "D:\\upload\\" + dateStr+"\\"+uuid+"." + prefix;

                File files=new File(filepath);
                //打印查看上传路径
                System.out.println(filepath);
                if(!files.getParentFile().exists()){
                    files.getParentFile().mkdirs();
                }
                file.transferTo(files);
                Map<String,Object> map2=new HashMap<>();
                Map<String,Object> map=new HashMap<>();
                map.put("code",0);
                map.put("msg","");
                map.put("data",map2);
                map2.put("src","/images/"+dateStr+"/"+uuid+"." + prefix);
                return map;
            }

        }catch (Exception e){
        }finally{
            try {
                if(out!=null){
                    out.close();
                }
                if(fileInput!=null){
                    fileInput.close();
                }
            } catch (Exception e) {
            }
        }
        Map<String,Object> map=new HashMap<>();
        map.put("code",1);
        map.put("msg","");
        return map;

    }

    @ResponseBody
    @RequestMapping("/downLoad")
    public void downLoad(HttpServletRequest request, HttpServletResponse response) throws Exception {
        File downLoadFileDir=new File("D:\\upload");
        String aFileName=null;//要下载的文件名
        FileInputStream in=null;
        ServletOutputStream out=null;
        request.setCharacterEncoding("utf-8");
        try{
            aFileName=request.getParameter("url");
            if(aFileName.length()>7){
                aFileName = aFileName.substring(7,aFileName.length());
            }
            response.setHeader("Content-Type","application/x-msdownload");//设置下载文件使用的报头
            response.setHeader("Content-Disposition","attachment;filename="+toUTF8String(aFileName));
            in=new FileInputStream(downLoadFileDir+File.separator+aFileName);//读入文件
            out=response.getOutputStream();//得到输出流,用于向客户端输出二进制数据
            out.flush();
            int aRead=0;
            byte b[]=new byte[1024];
            while((aRead=in.read(b))!=-1 && in!=null){
                out.write(b,0,aRead);}
            out.flush();
            in.close();
            out.close();
        }catch(Throwable e){
            e.printStackTrace();
        }

    }

    public static String toUTF8String (String str) {
        StringBuffer sb=new StringBuffer();
        int len=str.length();
        for(int i=0;i<len;i++) {
            char c=str.charAt(i);
            if(c>=0 && c<=255)
            {
                sb.append(c);
            }
            else {
                byte b[];
                try {
                    b=Character.toString(c).getBytes("UTF-8");
                }
                catch(UnsupportedEncodingException e) {
                    e.printStackTrace();
                    b=null;
                }
                for(int j=0;j<b.length;j++)
                {
                    int k=b[j];
                    if(k<0) {
                        k&=255;
                    }
                    sb.append("%"+Integer.toHexString(k).toUpperCase());
                }

            }
        }
        return sb.toString();
    }
}
