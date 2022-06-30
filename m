Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6878C433EF
	for <rcu@archiver.kernel.org>; Thu, 30 Jun 2022 04:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiF3EZr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jun 2022 00:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiF3EZq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jun 2022 00:25:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9F7377C5
        for <rcu@vger.kernel.org>; Wed, 29 Jun 2022 21:25:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so857306wmp.3
        for <rcu@vger.kernel.org>; Wed, 29 Jun 2022 21:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XF5+1TpNEHAiXDfVWQuBqZGuz8O67KY9U2sjyk0++xA=;
        b=J/ogTuEcBjzc2rb/AX+pBYkVOtdqmFsidowp9idjspZWWtBCu0QpR9Omff+s+WRE4J
         JQqudj/2Cr2qfjcFMt/rm61kR9b0uS6bBZ9XePjS6rge69pJNaxwG4FsPwBmcjgahoIT
         zZ7xrswxi9aUQCIcykenow5cV1Jz6mOyIW2DJheISuKWr7KK/QYsFfFUTz46tTEUfApa
         IsdiNxH21cVIcqCO/V4VZhpjVPJEdc87M9ji/eiTZcXPmWU0DsAVN72/jxdKBCH3gL1n
         EWu/46jkA03D7DfT6mJU1cICL9/sZULYP1olO9hZtpAZ0rLsl247j0otusmUTpKjqAdj
         5pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XF5+1TpNEHAiXDfVWQuBqZGuz8O67KY9U2sjyk0++xA=;
        b=kUt0yc9SyUULL4Wu35Xg4I6xIudUGBqmQG5OlIjbX9FOkAOiz8lSwi1SaUGA+7Pxpk
         1nHEt1Uug99a+TUDfk4kuDQRHeQgqDDftCj6CijEfB2HliNfL3ammfQO8xXydpFbT2lV
         I81KRHhgK/xI6+i0smV0+pp18FqjcJjeDOYMP2EPZQxUvkNKCAi/IDDyLiq7/Ohl/IDN
         1VAV2UCl4Mr/zQwJxVO3Q83sVJ5gcy9jkKTy2Ud76175DVcvCNmIcVEah6tVV08jsKHB
         Sn05r3U0ObaHWGGbWj9AAIGD1CQ5qD/xJpBq09qQxS2fm7LiAqn3YL47AUJ54gzsIfo/
         VtEg==
X-Gm-Message-State: AJIora9Ym6bZSO89Mgjg+qc/HPb1qHHdpwA/tmBh/mGfv99SyJ8OjLVW
        zoFzAXafYHAEkwtOzcmKQHBUMSatdqdGKyfraBGQWw==
X-Google-Smtp-Source: AGRyM1uujfLK/yIN8VLByYx5OAyz3aygJHVOScpq0uxooZ08lDRQ3geR/QBC9YsnqM9Hy0OG7EskPqyOaUSnSkkqoHQ=
X-Received: by 2002:a05:600c:3553:b0:3a0:519b:4b96 with SMTP id
 i19-20020a05600c355300b003a0519b4b96mr7335634wmq.61.1656563143223; Wed, 29
 Jun 2022 21:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <Yrx8/Fyx15CTi2zq@zx2c4.com> <20220629163007.GA25279@lst.de>
 <Yrx/8UOY+J8Ao3Bd@zx2c4.com> <YryNQvWGVwCjJYmB@zx2c4.com> <Yryic4YG9X2/DJiX@google.com>
 <Yry6XvOGge2xKx/n@zx2c4.com> <CAC_TJve_Jk0+XD7VeSJVvJq4D9ZofnH69B4QZv2LPT4X3KNfeg@mail.gmail.com>
 <YrzaCRl9rwy9DgOC@zx2c4.com> <CANDhNCpRzzULaGmEGCbbJgVinA0pJJB-gOP9AY0Hy488n9ZStA@mail.gmail.com>
 <YrztOqBBll66C2/n@zx2c4.com> <YrzujZuJyfymC0LP@zx2c4.com>
In-Reply-To: <YrzujZuJyfymC0LP@zx2c4.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 29 Jun 2022 21:25:32 -0700
Message-ID: <CAC_TJvcNOx1C5csdkMCAPVmX4gLcRWkxKO8Vm=isgjgM-MowwA@mail.gmail.com>
Subject: Re: [PATCH] remove CONFIG_ANDROID
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     John Stultz <jstultz@google.com>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, sultan@kerneltoast.com,
        android-kernel-team <android-kernel-team@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 29, 2022 at 5:30 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey again,
>
> On Thu, Jun 30, 2022 at 2:24 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > 1) Introduce a simple CONFIG_PM_CONTINUOUS_AUTOSLEEPING Kconfig thing
> >    with lots of discouraging help text.
> >
> > 2) Go with the /sys/power tunable and bikeshed the naming of that a bit
> >    to get it to something that reflects this better, and document it as
> >    being undesirable except for Android phones.
>
> One other quick thought, which I had mentioned earlier to Kalesh:
>
> 3) Make the semantics a process holding open a file descriptor, rather
>    than writing 0/1 into a file. It'd be called /sys/power/
>    userspace_autosleep_ctrl, or something, and it'd enable this behavior
>    while it's opened. And maybe down the line somebody will want to add
>    ioctls to it for a different purpose. This way it's less of a tunable
>    and more of an indication that there's a userspace app doing/controlling
>    something.
>
> This idea (3) may be a lot of added complexity for basically nothing,
> but it might fit the usage semantics concerns a bit better than (2). But
> anyway, just an idea. Any one of those three are fine with me.

Two concerns John raised:
  1) Adding new ABI we need to maintain
  2) Having unclear config options

Another idea, I think, is to add the Kconfig option as
CONFIG_SUSPEND_SKIP_RNG_RESEED? Similar to existing
CONFIG_SUSPEND_SKIP_SYNC and I think it would address those concerns.

--Kalesh

> Jason
