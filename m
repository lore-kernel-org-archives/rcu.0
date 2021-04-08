Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB67C43461
	for <rcu@archiver.kernel.org>; Thu,  8 Apr 2021 12:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D514A610E5
	for <rcu@archiver.kernel.org>; Thu,  8 Apr 2021 12:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhDHMp1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHMp1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Apr 2021 08:45:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590FC061760
        for <rcu@vger.kernel.org>; Thu,  8 Apr 2021 05:45:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u17so2826791ejk.2
        for <rcu@vger.kernel.org>; Thu, 08 Apr 2021 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UMuAklHy/tPt7YPBozpvIQsmWDAIa3a/la6+zoUVcdI=;
        b=JXlbvdv6BKxL2QLt+A6EZMYCjKur7zKVGHA+SPjjhttU3LjU5J8CTsvMPL70CwGYsq
         CUXz1jkKLkBNcttlxCmAirFDD+kjBSkQXhxTFfLF/zDE+suTqi1E02kHIf/SGivtkXXC
         r7MEDlKMlo41vpb3rOrLkq/HnnmBY745AuXsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMuAklHy/tPt7YPBozpvIQsmWDAIa3a/la6+zoUVcdI=;
        b=DcIHmE7KvOpnOcCkK0HqYpBW0dPrarKPGxmhAi5dxvztjieXOWMQcPzuCZNvszp9hW
         36oy1mTIzgQ23LLyzrWt7+OpFLvKENhw14wte6qxPBlJNGXQxJQWcfBQe5wXZFrUpNNc
         aDR39Q6faGKPTq7apwCoC1g1Afo7D3bxKaGtpfy5j6raxfbmTd6+9pL7D4iK6KS4ogDL
         wAnhh7nCcnl/oQHoKUL/1r3xXj4aM4Ppf4KsRa7E8D0so1M4uMXpS05L9chaMmaOaHvz
         m0azRFvaDltnNfUhvn5/71vU3/staaoo43dtz6dY6yqKAN4LTLduMjhp8zcoihO7wRCF
         7lUg==
X-Gm-Message-State: AOAM533jnpfNr1PnWuxNg0NzAJii2mBm/vQJ+rU5Tb9T18tuIlaVoWDw
        eFmz8p5eL30ofvQqFm2G3aFmWg==
X-Google-Smtp-Source: ABdhPJwq7QZNDA3D6CGhNZXcz6mj8YzK/fNHfbq7NkBvOdUqzkgcZZF3Ehka2wUefbZcZbtsp6oq8w==
X-Received: by 2002:a17:906:1fd7:: with SMTP id e23mr400958ejt.528.1617885914623;
        Thu, 08 Apr 2021 05:45:14 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id r4sm14262813ejd.125.2021.04.08.05.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 05:45:14 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <03be4ed9-8e8d-e2c2-611d-ac09c61d84f9@rasmusvillemoes.dk>
Date:   Thu, 8 Apr 2021 14:45:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 06/04/2021 15.31, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.

Yay.

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.

I think it would be good to have some place to note that "This #include
is just for backwards compatibility, it will go away RealSoonNow, so if
you rely on something from linux/panic.h, include that explicitly
yourself TYVM. And if you're looking for a janitorial task, write a
script to check that every file that uses some identifier defined in
panic.h actually includes that file. When all offenders are found and
dealt with, remove the #include and this note.".

> +
> +struct taint_flag {
> +	char c_true;	/* character printed when tainted */
> +	char c_false;	/* character printed when not tainted */
> +	bool module;	/* also show as a per-module taint flag */
> +};
> +
> +extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];

While you're doing this, nothing outside of kernel/panic.c cares about
the definition of struct taint_flag or use the taint_flags array, so
could you make the definition private to that file and make the array
static? (Another patch, of course.)

> +enum lockdep_ok {
> +	LOCKDEP_STILL_OK,
> +	LOCKDEP_NOW_UNRELIABLE,
> +};
> +
> +extern const char *print_tainted(void);
> +extern void add_taint(unsigned flag, enum lockdep_ok);
> +extern int test_taint(unsigned flag);
> +extern unsigned long get_taint(void);

I know you're just moving code, but it would be a nice opportunity to
drop the redundant externs.

Rasmus
