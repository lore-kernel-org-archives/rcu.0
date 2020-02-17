Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3674C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 14:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62CC20718
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 14:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="J2dhYajX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgBQOoy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:44:54 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45315 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgBQOoy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 09:44:54 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so7651136qvu.12
        for <rcu@vger.kernel.org>; Mon, 17 Feb 2020 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsx+wahmLncxpAibGBMLE7yjCXhaabzr487R2xybgcY=;
        b=J2dhYajX+3aK/Tl/84yD3Bi6131O43n7cy+k094zy7ZzLPXWufUVCIqB2b9zfhWm8P
         DDQlE2Pj8OIkxohd+HT2D7AkYIJVmel4T1wlH8lyNpjvR/QojGDCrJXPknKP05PcGGGS
         vKPO4sqiqeBWHIcMIYPzHsa2NoykHEysvYd20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsx+wahmLncxpAibGBMLE7yjCXhaabzr487R2xybgcY=;
        b=EIC7am0CFU7dkPx9DXU1Eksj7hIh5WjE1YIBx0uwjz4KOgFB6hUCJ46usDLV2G09Dn
         uly8QJ+/WT/3U+RRpSEzwBFwIgV9bcQFneP2g9vYk4WXfT+iqNY511BE6w7qJ4qXCCNY
         M03QCqpnv1C7jOZ2C1ELzrofSq/pg7hTJjN6XxtJcINBIWeTTHtJyg1eYKNLXQaz/tUo
         Ln43CakzKxxR7xBO6vICuAI3bpArjWvntKt488garGFHhGpb2c0/IsBu4uN3GlH/gTwq
         +nV5Kecx5c+fR/2HUb1iL0ZjM2L35JxXRYXUIBsasfRile0/SZTW5jqB2MJ9SQugQNua
         gTdg==
X-Gm-Message-State: APjAAAUTAjb01krrxJ95mnj30tRq/Xgq2DWAiEC9Hk5ARBp1bUoa90Ki
        9Z2vbsPQrcsEj/6DNTK153erPg==
X-Google-Smtp-Source: APXvYqw5CRRXqTe6H1jSFgKR4/lO+W2xZgwPa0GjoYZopskBFDQQCTaSgnvfDaXmVt7fnV6IDpKGmA==
X-Received: by 2002:a0c:ab8f:: with SMTP id j15mr12855205qvb.223.1581950693324;
        Mon, 17 Feb 2020 06:44:53 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m10sm314991qki.74.2020.02.17.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 06:44:52 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:44:52 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Jules Irenge <jbi.octave@gmail.com>
Subject: Re: [PATCH tip/core/rcu 2/3] rcu: Add missing annotation for
 exit_tasks_rcu_start()
Message-ID: <20200217144452.GA145700@google.com>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215002520.15746-2-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 14, 2020 at 04:25:19PM -0800, paulmck@kernel.org wrote:
> From: Jules Irenge <jbi.octave@gmail.com>
> 
> Sparse reports a warning at exit_tasks_rcu_start(void)
> 
> |warning: context imbalance in exit_tasks_rcu_start() - wrong count at exit
> 
> To fix this, this commit adds an __acquires(&tasks_rcu_exit_srcu).
> Given that exit_tasks_rcu_start() does actually call __srcu_read_lock(),
> this not only fixes the warning but also improves on the readability of
> the code.

For patch 1/3 and 2/3:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Though IMO it would be good to squash both the patches.

thanks,

 - Joel


> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index a27df76..a04fe54 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -801,7 +801,7 @@ static int __init rcu_spawn_tasks_kthread(void)
>  core_initcall(rcu_spawn_tasks_kthread);
>  
>  /* Do the srcu_read_lock() for the above synchronize_srcu().  */
> -void exit_tasks_rcu_start(void)
> +void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
>  {
>  	preempt_disable();
>  	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> -- 
> 2.9.5
> 
