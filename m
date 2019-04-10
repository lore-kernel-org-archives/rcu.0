Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93551C10F0E
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 01:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F18D2133D
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 01:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bzVa0hQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDJBR6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:17:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44427 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJBR6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Apr 2019 21:17:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so286118pll.11
        for <rcu@vger.kernel.org>; Tue, 09 Apr 2019 18:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LRe7y/AmJSwRL6mJ4EhTLWkHwjbyqszlgX6hCqpGIpA=;
        b=bzVa0hQqSZZ09BDV9/CL4c0IOihjw3kM/nQ7sstg7B6YFJ5f/Q/MfaysxocEws1SJ5
         Fg89TSmGZarqjHZgjqJNNZ6G7lOyD/9LPzjofKvB/zY2bjDAeqo1NQYCsXNeVubdkQLg
         JOplujQg1A0aeGEtyl23gOWwY4Kd2TE9DyTaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LRe7y/AmJSwRL6mJ4EhTLWkHwjbyqszlgX6hCqpGIpA=;
        b=hX0iReu2ceFrl3PVkbuNxsL1hhnoTZVvZTDKBJQOFNm5bdmKuzSsQlWWhjSs453wnG
         fLE9MCCmlM3WH7mJ0TfI2/masv7QJXCGJJx+1JXtn2GLdihPkSxZsjHBFWQQivuFKOh5
         e24Rz+IadrIuuqTQt5zLAndY9uqrZpBzY4Z/ZoXZ9Gy4jYFPD1XWR2aXzudb3U3U2SgU
         5pjY3xGBUFCwz3ETYALi36xAeWoDVbEIksXK55DWEG1Yz9AkF08flZuNFsbLcgCn4xQ5
         k9woRMMcpTPrxuVwkwm0ugqbNVKjFqjxzMp4gY7+tiTEEW7DXQfvmInA5qkqO0dJqtwM
         MTgw==
X-Gm-Message-State: APjAAAXeNCsh2zwp3DxJZ4GDruJ2qBLIDwcTZArohML9BTz94LGLYZMt
        /r2kXEmJ+8+73xmo/68chv/aWg==
X-Google-Smtp-Source: APXvYqzKxY8fL4oKhyL+821YIinILRxuyPjKXmgDRrcRV16KQ5xcR2wmZp5miEv0WSpZgZeTsDvk0g==
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr1695508pls.302.1554859077978;
        Tue, 09 Apr 2019 18:17:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k79sm16509465pfj.28.2019.04.09.18.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 18:17:57 -0700 (PDT)
Date:   Tue, 9 Apr 2019 21:17:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] module: Make srcu_struct ptr array as read-only post
 init
Message-ID: <20190410011756.GA78239@google.com>
References: <20190410011418.76408-1-joel@joelfernandes.org>
 <20190410011418.76408-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410011418.76408-2-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 09, 2019 at 09:14:18PM -0400, Joel Fernandes (Google) wrote:
> Since commit title ("srcu: Allocate per-CPU data for DEFINE_SRCU() in
> modules"), modules that call DEFINE_{STATIC,}SRCU will have a new array
> of srcu_struct pointers which is used by srcu code to initialize and
> clean up these structures.
> 
> There is no reason for this array of pointers to be writable, and can
> cause security or other hidden bugs. Mark these are read-only after the
> module init has completed.
> 
> Suggested-by: paulmck@linux.vnet.ibm.com
> Suggested-by: keescook@chromium.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Just wanted to mention, that I tested that the srcu_struct_ptrs array is not
writeable any more after init, but doing the following after
module_enable_ro() :

@@ -3513,6 +3523,14 @@ static noinline int do_init_module(struct module *mod)
        rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
        module_enable_ro(mod, true);
+
+       if (mod->srcu_struct_ptrs) {
+               // Check if SRCU Access is possible
+               char x = *(char *)mod->srcu_struct_ptrs;
+               *(char *)mod->srcu_struct_ptrs = 0;
+               *(char *)mod->srcu_struct_ptrs = x;
+       }
+
        mod_tree_remove_init(mod);
        disable_ro_nx(&mod->init_layout);
        module_arch_freeing_init(mod);


thanks,

 - Joel

> 
> ---
>  kernel/module.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index f9221381d076..ed1f2612aebc 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3301,7 +3301,7 @@ static bool blacklisted(const char *module_name)
>  core_param(module_blacklist, module_blacklist, charp, 0400);
>  
>  /*
> - * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> + * These are section names marked with SHF_RO_AFTER_INIT so that
>   * layout_sections() can put it in the right place.
>   * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
>   */
> @@ -3314,6 +3314,13 @@ static char *ro_after_init_sections[] = {
>  	 * annotated as such at module load time.
>  	 */
>  	"__jump_table",
> +
> +	/*
> +	 * Used for SRCU structures which need to be initialized/cleaned up
> +	 * by the SRCU notifiers
> +	 */
> +	"___srcu_struct_ptrs",
> +
>  	NULL
>  };
>  
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
