Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC55C433F5
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 18:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242892AbhKXSE1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbhKXSE1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 13:04:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708DCC061574;
        Wed, 24 Nov 2021 10:01:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so14006268eds.10;
        Wed, 24 Nov 2021 10:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgvkuWffJgeKcOJSjzRnBTmZU44ZLWgvH/oAgfUpzLw=;
        b=qBUNVYjBN3se9gCpBMIxTja97ivHMWOHBrldWl9xs+HerYFhCWuk1xIGM/PeMMM7be
         WIuXtnMWVZQq4SPAMjHsgfxHdKbwP342UDX0Hl3nM6IYyN5IZMfgu2AFYYzwIKE0HujD
         LLUesToo4JOgKjwWkBoAyYLukmZLotOpGKZEKcLYp4ZgDFwseE2yf4gLcysU2iMdA7ip
         aiqrhG10qzD9yHRVAbsnYpdK2JUwjRyVBNgz/gMn4GW+gIqisGZyyjvf/rXyIxfALjzc
         bkSY7IdWlb4s+/p7Oj5ll0XTfh+sMbA9/ejl4Qnd5sHdbTE3ykXcj0mEsS27RknRdyFk
         KeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgvkuWffJgeKcOJSjzRnBTmZU44ZLWgvH/oAgfUpzLw=;
        b=atq3kGWm69dqhEV0CHMv4Jk7NYKhp0GPuAgjwJQ7NA9C5VRHUZLIbBUY/zgiqxgjyc
         4TkVrkNAMoX/qFjlUs5BZTLlrnZhSAHuaefb9/XCwrt58ysp3/Gb916h7zXe442CMCJS
         3ryxhkCkw0I766C82ZOeDbTLMu89V74q9UoQnC2LB7Qv4OepynXMMxH6v9ZbHRDLp/Z2
         XRKouMlaO30ThQyYDgaJRIdFORPPDIyRrPM4Zl/1A5+NrnfEWWEAYul1NuU6t8k4tzOH
         C4LC6G28igCLcxs5XR9e4N1ncR1DUUhweMancvCYE9M3x5Wp7p0J0mTja9er/LDInatL
         E94Q==
X-Gm-Message-State: AOAM531E4zwJkbpr83npWJrX6yc7OB5I5MJIiLDWvI4o75t/xm8S76se
        z28XrprsP6NiKV8JsrY+gIXNLethGCKSem31qBC0AA62DwtyIw==
X-Google-Smtp-Source: ABdhPJxLQZJ2EiGGfF/xxNojY/VMnqAS1LZSiaNfLCBq9AToXimWYVKWVuKP9E57DbMYIYtJXQPrUE6I0Z+bgJ0kW3A=
X-Received: by 2002:a05:6402:3551:: with SMTP id f17mr27901870edd.129.1637776875909;
 Wed, 24 Nov 2021 10:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20211124110308.2053-1-urezki@gmail.com> <20211124110308.2053-6-urezki@gmail.com>
 <20211124095803.2702bc89@gandalf.local.home>
In-Reply-To: <20211124095803.2702bc89@gandalf.local.home>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 24 Nov 2021 19:01:04 +0100
Message-ID: <CA+KHdyWg=4i5xu7oRDqi5cFJ6_PjwghrVR3L0mN-PwQ7YwCmZg@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/mm: Switch to kvfree_rcu() API
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
> This is the first I've seen kvfree_rcu() (that I actually noticed/remember,
> I'm sure I probably was Cc'd on some patches). And I find the comment
> around it very confusing:
>
> Specifically:
>
>
>  *     kvfree_rcu(ptr);
>  *
>  * where @ptr is a pointer to kvfree().
>
> The above suggests that you should pass a pointer to the actual function
> kvfree to kvfree_rcu(), which is not what I believe is to be done.
>
>   i.e.  kvfree_rcu(kvfree) ???
>
> Perhaps rewrite that to say:
>
>  * where @ptr is the pointer to be freed by kvfree().
>
> ?
Indeed. I will fix that by sending a patch to change a description to
be less confusing :)

>
> Other than that, the patch looks fine to me.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
I will place your "Acked-by" to 9/9 one.

Thanks!

-- 
Uladzislau Rezki
