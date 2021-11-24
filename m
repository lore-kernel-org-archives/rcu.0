Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B957FC433F5
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 18:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhKXSG0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbhKXSG0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A32C061574;
        Wed, 24 Nov 2021 10:03:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y13so14074051edd.13;
        Wed, 24 Nov 2021 10:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+laNQIYh8Dw2XU39b20AfbA+LAdl6wkrn7y2w7blNzI=;
        b=XqPlmC/VExwhkDnyDEJpyd99XyCEm0qomUFZd9xc5dURWdkjgmbJ8gyVqq2VPZE9EG
         9pdZmHekqwsHDVfLSTFaPudXCLXLelX+r18s3KVLVtG2FvsvXAu31aZtZjoB8I2Ob/hC
         KdOQ1DTIF8O3FvZXwsgVUBDVy3attLBNiVh8gpIVzdxZaj97GXhr6eiAWpyjgqRsSuhq
         dAN5VaQsKROGQpYjY0hQrwp/02G5let38fREfkL2vXguZ+AMalAIgb38s8SnERGq2UO1
         EgZ9oQD7RKaI4pCEXnAbOjnOVK8Kdk18MU0+jfS2n5yuQJsgWlT3vie635rPJoSbD79m
         8ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+laNQIYh8Dw2XU39b20AfbA+LAdl6wkrn7y2w7blNzI=;
        b=TSrZQsLpmPEcR1lbrF3cr2HNSQolyylSzAptV40/mxJjQqabjQw+qsEQWVMHMrRLcB
         5X7n5W4jtX9W/m6r/Te2dQrK2VcPf/SG9NFPEOXibjzFPZ/sb7reZRbYmQDIckGmusSr
         FsjOwfUcf8HhrB8j91CW/TDqWB7mYWzhAh8D2+rR6HYG/2VLChISP+l1S766Glow5tCw
         zLI3Qtvb+fKYSQjKSCrjstiFuzVKzCKbmHcYYccW7YkH+ho0dY4loztiZEWpj/YyChlR
         VZF6KVtAzeqRX+Mp+yw92z9CBh39goaONgOMBntOojXoXlFq04cmqZUjFMLPYVZ4XQOf
         A8gQ==
X-Gm-Message-State: AOAM530VnkCB0+syNdxOVa9WcaG2j5096Ae6xPWZJMMx5C5xl6AlHvOM
        OLgzDQhNbQHKi5qzQB9gUJA89kIThKp0M4OoapA=
X-Google-Smtp-Source: ABdhPJzjhaKVvppk8il3BVKqztj7FK88tLSfv7wxzx89bp1pwYvahgF0DDoGj/PZ1L8LAsjiv2tTx/kh/lEg1izDi8c=
X-Received: by 2002:a05:6402:8c9:: with SMTP id d9mr27893657edz.254.1637776994872;
 Wed, 24 Nov 2021 10:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20211124110308.2053-1-urezki@gmail.com> <20211124110308.2053-10-urezki@gmail.com>
 <20211124100003.7d09a7d8@gandalf.local.home>
In-Reply-To: <20211124100003.7d09a7d8@gandalf.local.home>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 24 Nov 2021 19:03:03 +0100
Message-ID: <CA+KHdyWmbeMjAQhMiKJuokj1eCOoEvqJ3=UZRZhhp_bAXWNYOg@mail.gmail.com>
Subject: Re: [PATCH 9/9] tracing: Switch to kvfree_rcu() API
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
> On Wed, 24 Nov 2021 12:03:08 +0100
> "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
>
> > Instead of invoking a synchronize_rcu() to free a pointer
> > after a grace period we can directly make use of new API
> > that does the same but in more efficient way.
> >
> > CC: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
>
> Replying to the correct patch this time.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
Thanks!

-- 
Uladzislau Rezki
