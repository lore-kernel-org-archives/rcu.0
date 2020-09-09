Return-Path: <SRS0=NFG3=CS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2433C43461
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 09:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A0320757
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 09:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EJ/2Q9mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIIJYd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIJYR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Sep 2020 05:24:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF7C061573
        for <rcu@vger.kernel.org>; Wed,  9 Sep 2020 02:24:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m8so1654794pgi.3
        for <rcu@vger.kernel.org>; Wed, 09 Sep 2020 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w90SDair7JoYZHSRoRms18sB50MZLQwaofVsG2qPpa8=;
        b=EJ/2Q9mh4RsgGvFBloK2ugShDt2KEkXAUz0NeIxbxLw+gXMFwFOR2UefTyJIGgIvPG
         ZDQVdt1k2GMTfxz/eCpTmcD/UamwfI+0hYr9HPNEYQLlyoZNXpIDELDe0En9HXsmd5me
         h01y22hF1VBRWadrSvKeL2m8CjS4CUyHDX3KMH5hi/gp/wU6TLu8NyvxsDj9WDW8esRX
         hvM8/xVnieYm4raxwIXM4opmZ9lIbzsru80k8koVspDr4Pbvegv0zwDeCqB1ABdcPM74
         M+9CcWCt/Ycu5ctUDLkPKNJhebloHpyf3VyrsvE5lPJNnOdsRb1j7maQp3OpiBYSsHBF
         o3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w90SDair7JoYZHSRoRms18sB50MZLQwaofVsG2qPpa8=;
        b=ki/9n8rvOIi6lwIYJN/DpmN7mZRcktiYnVFuy9Sb05lNfK2Iue8e3lPw+oGLTgJOZq
         uz0laotzrqQ/s/Ioq8/1zByCBD0ZDtsrr1TU1+GQhvA/j35iOt6+1WFKh+OzEMPuVv3t
         LPAsmPwfy4gG7zE9SRvwGZdgPtqbr0v1ar0jch88+kW/GCCh5FrCG6ElVsvNaZIKZDYi
         v9ecdkKJiMofSGl0SEYX0MmzJeQ51ElAGe1qFLRu/QofSk1pTREeISQ/ctHQJcaBRsNG
         F0yG/EOPGxJ4UjyD1xQR9gPs9a1bxz99/C4yRnNBZIDYsB6igxskzqXVe0frQ8hK928M
         5qJg==
X-Gm-Message-State: AOAM530urLLUhI40eyMtxTB21nRTu92M2QSvViD6U7o+HcIDlvCKP+uR
        +uHh0LyQ9eIQ4JYGI5JGxYHAug==
X-Google-Smtp-Source: ABdhPJwDC7CCcMjIw2sNP/CE7OjrggwmsplFHFFErgXAaC/qgWnpNcK/Vyr8gJ9TXcYCtvwwmagIWA==
X-Received: by 2002:a63:4c57:: with SMTP id m23mr2237110pgl.77.1599643456997;
        Wed, 09 Sep 2020 02:24:16 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id q5sm2042175pfn.172.2020.09.09.02.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:24:16 -0700 (PDT)
Subject: Re: [PATCH kernel] srcu: Fix static initialization
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <20200908144306.33355-1-aik@ozlabs.ru>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <cc25257d-804e-8cf7-150b-e6bdbaf184be@ozlabs.ru>
Date:   Wed, 9 Sep 2020 19:24:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200908144306.33355-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 09/09/2020 00:43, Alexey Kardashevskiy wrote:
> init_srcu_struct_nodes() is called with is_static==true only internally
> and when this happens, the srcu->sda is not initialized in
> init_srcu_struct_fields() and we crash on dereferencing @sdp.
> 
> This fixes the crash by moving "if (is_static)" out of the loop which
> only does useful work for is_static=false case anyway.
> 
> Found by syzkaller.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  kernel/rcu/srcutree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index c100acf332ed..49b54a50bde8 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -135,6 +135,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
>  				   levelspread[level - 1];
>  	}
>  
> +	if (is_static)
> +		return;

Actually, this is needed here too:

 if (!ssp->sda)
         return;

as
ssp->sda = alloc_percpu(struct srcu_data)

can fail if the process is killed too soon - it is quite easy to get
this situation with syzkaller (syscalls fuzzer)

Makes sense?


> +
>  	/*
>  	 * Initialize the per-CPU srcu_data array, which feeds into the
>  	 * leaves of the srcu_node tree.
> @@ -161,8 +164,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
>  		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
>  		sdp->ssp = ssp;
>  		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> -		if (is_static)
> -			continue;
>  
>  		/* Dynamically allocated, better be no srcu_read_locks()! */
>  		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
> 

-- 
Alexey
