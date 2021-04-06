Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F5C433B4
	for <rcu@archiver.kernel.org>; Tue,  6 Apr 2021 14:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E56A6138B
	for <rcu@archiver.kernel.org>; Tue,  6 Apr 2021 14:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbhDFOaH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbhDFOaF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Apr 2021 10:30:05 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3197EC061756
        for <rcu@vger.kernel.org>; Tue,  6 Apr 2021 07:29:57 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so14791822otk.5
        for <rcu@vger.kernel.org>; Tue, 06 Apr 2021 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hQuAvIyYNagg9JyQzFat1nJUGgDzxw1aFC3YiFQyaP8=;
        b=r0xxTuGtRNzYKu8nqiDI+DB5zSPkGLUpbLgQNQaGLGkgiwpw5MLANjpcq8MYaU0Hq2
         X8hOUDV1/oX/57fSmkTii8Bi2YNGL51y3lk4KSq6YfYCl9xD99P2sRCmzVmEG58kiwA4
         O05ho4ncMEJoZb938OZlbjiRKlK/EjE9hdYwjEFKVhW8aa5VjYe3kTtXHut1plKroA5I
         LK8jHR4u1E1zwzgU3jfR/e97UySNVfA6xtYPZDw8iliqxhEF4hMoTSEYpSrDe0cNmIoT
         5uGPRIzoOUAtKfyfQyD6S4s1F14OHjawgvJvGlkrf0GyIfoE+3kDp/xK61HSyY5bjF7+
         zvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQuAvIyYNagg9JyQzFat1nJUGgDzxw1aFC3YiFQyaP8=;
        b=lYF/6/on4huMoog9Od6xVzucOblCKYjwbm0NNlBxstKu8VgL2qXEpDoFzQN7YKqaEG
         7vFib2y5BBOf4dSL98690WBisyYBz1HQwhxMoI1ZFrl/0fcEjdtSQFFWa3XhtsFQ/2cz
         Iug5HyJ6Rni7TVTD0MTpzjzNxwzB6G2os4EchKEKW2GwPzxZ1HFuKrGReq4BkqAEaR1Y
         NQGgkLxqo48+sJtx/PVW6w+czXn8C3NkoXgRi53USJjOnHJZwNZ/q+8niYSqOn1mNDoK
         S8fgEVCeKUbdZfdFuBiSSkJbjitTTjxuvTNM6w6QGtHhTj212i/Jfn+7DRmIJzZ+3ASL
         sgLg==
X-Gm-Message-State: AOAM533hvsvjzT1UlaiqgaujGPBUWv/2dXDXq2mI7pXe/NWIQ6wTfDkL
        AcpnjiHqdxI22A3t92FTFd84oA==
X-Google-Smtp-Source: ABdhPJwoj/Chr5jtxoWPmUxeZgdomq36W/mf+NaHAUUL9Ola9ZGgZLXjYEl5wLxRYiH8O3M4xb6gkw==
X-Received: by 2002:a05:6830:309d:: with SMTP id f29mr26342263ots.225.1617719396349;
        Tue, 06 Apr 2021 07:29:56 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d13sm4689185otk.74.2021.04.06.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:29:55 -0700 (PDT)
Date:   Tue, 6 Apr 2021 09:29:52 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
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
        linux-fsdevel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <20210406142952.GG904837@yoga>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 06 Apr 08:31 CDT 2021, Andy Shevchenko wrote:

> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
> 
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
