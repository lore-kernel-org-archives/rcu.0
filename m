Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEB8EB64DC
	for <rcu@archiver.kernel.org>; Tue, 18 Jul 2023 12:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjGRM73 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Jul 2023 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjGRM72 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Jul 2023 08:59:28 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B35E4C
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 05:59:26 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403ee42444dso15760331cf.3
        for <rcu@vger.kernel.org>; Tue, 18 Jul 2023 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689685166; x=1692277166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5tt9zeLQ2+OjFi48j9FEVf0rh+9eU5vhKKJxQtews0=;
        b=micTBVpm101CT2ld66mNBx1Untcd57oicFHLWr+1pRSRAr10iA6mnsKePo8SwbMu/9
         QfYj7peQd/ZXjHarnUwV57tPXAsZTwrRbvZkFTJtQndf2jWQWNKOPZz1b+LsqBA6V6rN
         LzLOdXxzRBT8m/oKr5vGFIxE4i1J9YfA9wVFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685166; x=1692277166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5tt9zeLQ2+OjFi48j9FEVf0rh+9eU5vhKKJxQtews0=;
        b=ayCjc8uTJPIPG5UXkOQVeEmHCh8SJxDj8sNPoewjjqI7VkWp7yVgV6dFXExnZWA0Lk
         PoSzFgTRsU1LienCgG/ywxnN4vib9m7AM54gQUItPbnWRvtSpt0dlFxBqGS2j6s9WWZq
         7D2TU+DuMxjhthgXOF+O3HvPV5JjIfdK5QTJGw79sPNRX0ZtuYbSDZpNzdGaYShMrp8H
         q3pR6TGwo942efevH+cZe1+2YjAwE/r+aD5qLWNA2VlpbS+Ug4wFM16AiNjcjTLyd9Ux
         nDG833SFwjQT/+3M+TwqLvnPU44yntiwt4mmmio3lGX7sA7mhYzsNqdw2cn6XFBACL0A
         eApQ==
X-Gm-Message-State: ABy/qLZfnVSpdqq/fLraFG3DRAJQmZV0Fx83iv/0ZlA/CU9NdOlIcrXZ
        dNZnWSPVB/X3OXxoiMvsWSVPSA==
X-Google-Smtp-Source: APBJJlEKkEI93fkUaO7eGvqCh1NR0xKX97RJyb9wB2iBrJqsMrY/hnaXb20JZ68zoLZiEiIj0P3M/w==
X-Received: by 2002:ac8:580f:0:b0:403:ebb2:dd4f with SMTP id g15-20020ac8580f000000b00403ebb2dd4fmr9621394qtg.59.1689685166040;
        Tue, 18 Jul 2023 05:59:26 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id gd25-20020a05622a5c1900b004033992e2dbsm625884qtb.45.2023.07.18.05.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:59:25 -0700 (PDT)
Message-ID: <e6ba1856-f54b-943e-d01d-097e88900846@joelfernandes.org>
Date:   Tue, 18 Jul 2023 08:59:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rcu 1/6] rcu: Update synchronize_rcu_mult() comment for
 call_rcu_hurry()
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-1-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230717180317.1097590-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 7/17/23 14:03, Paul E. McKenney wrote:
> Those who have worked with RCU for some time will naturally think in
> terms of the long-standing call_rcu() API rather than the much newer
> call_rcu_hurry() API.  But it is call_rcu_hurry() that you should normally
> pass to synchronize_rcu_mult().  This commit therefore updates the header
> comment to point this out.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   include/linux/rcupdate_wait.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> index 699b938358bf..5e0f74f2f8ca 100644
> --- a/include/linux/rcupdate_wait.h
> +++ b/include/linux/rcupdate_wait.h
> @@ -42,6 +42,11 @@ do {									\
>    * call_srcu() function, with this wrapper supplying the pointer to the
>    * corresponding srcu_struct.
>    *
> + * Note that call_rcu_hurry() should be used instead of call_rcu()
> + * because in kernels built with CONFIG_RCU_LAZY=y the delay between the
> + * invocation of call_rcu() and that of the corresponding RCU callback
> + * can be multiple seconds.
> + *
>    * The first argument tells Tiny RCU's _wait_rcu_gp() not to
>    * bother waiting for RCU.  The reason for this is because anywhere
>    * synchronize_rcu_mult() can be called is automatically already a full

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

  - Joel

