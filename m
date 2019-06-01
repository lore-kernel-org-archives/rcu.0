Return-Path: <SRS0=rUB2=UA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E07C04AB6
	for <rcu@archiver.kernel.org>; Sat,  1 Jun 2019 02:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21EB27074
	for <rcu@archiver.kernel.org>; Sat,  1 Jun 2019 02:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E7K3rAJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfFACIp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 22:08:45 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:34096 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfFACIp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 May 2019 22:08:45 -0400
X-Greylist: delayed 948 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 22:08:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=WOOhS
        5yuu+uyjSyW2+icauOgVQIB0mfTTXZlm+bneW4=; b=E7K3rAJJEaPbEKY0Nca99
        MQ42I9hxAP+VAIPOxeOkOlOqyLwsEPRkVPmR9BugQz2slwE48kjIQyHVLXRq5DOc
        KqLOuR9z78NXBnyhUVBqHJ7ICxVeGoZJ0PMz6V8erjdB1DMgVfuqJE2/UPjY42sN
        Ma6MCn9vYZi5ke+5AVQHCY=
Received: from [172.20.10.4] (unknown [122.192.14.47])
        by smtp15 (Coremail) with SMTP id GdxpCgBXW1NB2vFcB8l4AA--.19S2;
        Sat, 01 Jun 2019 09:52:02 +0800 (CST)
Subject: Re: [PATCH] rcuperf: correct a example of perf_type
To:     paulmck@linux.ibm.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org
References: <1559315745-26570-1-git-send-email-ice_yangxiao@163.com>
 <20190531190025.GP28207@linux.ibm.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <35a30752-383c-7d11-a7e5-a58ae2a8f7bd@163.com>
Date:   Sat, 1 Jun 2019 09:52:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190531190025.GP28207@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: GdxpCgBXW1NB2vFcB8l4AA--.19S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryrAr1xArWDZw1kAFy8uFg_yoW8Cw18pr
        WfCF17KrWkJryIganrArn5XFy5Xa98XF42qFnIq3y8tw1Yvr18JFnrKF1rXF909ry5JrW2
        qFsIq3y3Jw4kAwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b5NVkUUUUU=
X-Originating-IP: [122.192.14.47]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiTALGXlSIfi228QAAse
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 06/01/2019 03:00 AM, Paul E. McKenney wrote:
> On Fri, May 31, 2019 at 11:15:45PM +0800, Xiao Yang wrote:
>> rcu_bh type has been removed by commit 620d246065cd("rcuperf:
>> Remove the "rcu_bh" and "sched" torture types") and only four
>> types(i.e rcu, srcu, srcud, tasks) are supported currently, so
>> use srcu as a example.
>>
>> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> Good eyes, applied!
>
> I edited the subject and commit log as shown below.  Could you please
> check to make sure that I didn't mess something up?
>
> 							Thanx, Paul
Hi,

Thanks for your change, and it's fine to me.

Best Regards,
Xiao Yang
>
> ------------------------------------------------------------------------
>
> commit f499b80f236316c5f16c4d5c0d7804c258a003cb
> Author: Xiao Yang <ice_yangxiao@163.com>
> Date:   Fri May 31 23:15:45 2019 +0800
>
>      rcuperf: Fix perf_type module-parameter description
>      
>      The rcu_bh rcuperf type was removed by commit 620d246065cd("rcuperf:
>      Remove the "rcu_bh" and "sched" torture types"), but it lives on in the
>      MODULE_PARM_DESC() of perf_type.  This commit therefore changes that
>      module-parameter description to substitute srcu for rcu_bh.
>      
>      Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
>      Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 7a6890b23c5f..4513807cd4c4 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -89,7 +89,7 @@ torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable
>   
>   static char *perf_type = "rcu";
>   module_param(perf_type, charp, 0444);
> -MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, ...)");
> +MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, srcu, ...)");
>   
>   static int nrealreaders;
>   static int nrealwriters;

