Return-Path: <SRS0=q/VE=T7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B892C04AB6
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 15:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF77A26B79
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 15:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y1HgM+Jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaPQl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 11:16:41 -0400
Received: from m12-12.163.com ([220.181.12.12]:54888 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEaPQl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 May 2019 11:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=zbCob
        CS4MvnoT1Si5nkw5KDx9bhmP0l7+vOngC8LFtY=; b=Y1HgM+JdNJoIsmjboFrj/
        ciTV7E4KbwEheUm/gEc+BGx5bFAGHFjO2TBSOXTkQ2jD3S/+O1FZbzBTKVYIlJEd
        DQXKNtyPj0KiOd3T+HTH/8u12YMH0X6qfRdVtaYYZevf6YXibX9qu2i9t8Mdhafv
        JluRdJcQUdBYYg65qVEoPQ=
Received: from [192.168.1.212] (unknown [114.224.173.228])
        by smtp8 (Coremail) with SMTP id DMCowACnxCr_RPFcO_ofGQ--.64520S2;
        Fri, 31 May 2019 23:15:12 +0800 (CST)
Subject: Re: [PATCH] rcuperf: correct a example of perf_type
To:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Cc:     rcu@vger.kernel.org
References: <1559315543-26260-1-git-send-email-ice_yangxiao@163.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <d1720b0f-a92e-62cc-776c-4dd7e734bca9@163.com>
Date:   Fri, 31 May 2019 23:15:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1559315543-26260-1-git-send-email-ice_yangxiao@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DMCowACnxCr_RPFcO_ofGQ--.64520S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryrZF17AFyfWrWkZr4ktFb_yoWDXFc_Ww
        4xZrn5uw4UZFW09w17X34fZr4Yqry5CF1DZ3sIgr4vvr9xArZxA3s5Ar95Z3s3JrW8XF98
        C3sIgFyUKw4UAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUesvttUUUUU==
X-Originating-IP: [114.224.173.228]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbBEgDFXlZYCaVPkgAAs2
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

Sorry, please ignore this mail because of a typo.  I will resend it soon.

Best Regards,

Xiao Yang

On 05/31/2019 11:12 PM, Xiao Yang wrote:
> rcu_bh type has been removed by commit 620d246065cd("rcuperf:
> Remove the "rcu_bh" and "sched" torture types") and only four
> types(i.e rcu, srcu, srcud, tasks) are supported currently, so
> use scru as a example.
>
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> ---
>   kernel/rcu/rcuperf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 7a6890b..4513807 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -89,7 +89,7 @@
>   
>   static char *perf_type = "rcu";
>   module_param(perf_type, charp, 0444);
> -MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, ...)");
> +MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, srcu, ...)");
>   
>   static int nrealreaders;
>   static int nrealwriters;


