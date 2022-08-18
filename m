Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45954C00140
	for <rcu@archiver.kernel.org>; Thu, 18 Aug 2022 17:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbiHRRYP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345371AbiHRRXp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Aug 2022 13:23:45 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDCC2BB19
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 10:23:19 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q74so1582100iod.9
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=X1PRfiTW0ZbzrjEzYLkrMF9zmX77XAZwlizZppwE8xo=;
        b=HFpZqiw6dLHvq5WZeg7bibs3hsyLVsFFUbuqCGHj3ldaaTjWem7qmiSBSRW+4hYkCH
         ujoMpndvofRjFOGnHx+r7Q63iZcIM4J1gLBFkrl7tp3m5PQi4yT9ZAPqHpW3H/sYwF9w
         9Ffz8E72GXntPMRDj7Ca9IbL5MgWSCSZzqHOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X1PRfiTW0ZbzrjEzYLkrMF9zmX77XAZwlizZppwE8xo=;
        b=z9f15VvVEP8lEtsK/jGe5EadJRHiNjMIGJHkNNEqlwRdxcQFRo+JbSbujcK+cv05cf
         m2JQUZntpYG78DmohVkPmmMh+OBvIhEzNUwCMKg08KiSJKhAKiPRx5IG6XHzfvxeiRJ1
         SBVF42izP2BlqKXLj7gef068zfJ22uXRSOB448YsSXCJ5xDhDyauTC/at5xv+ovYLug3
         Ce8w7suMpGGSLuSz7DfsRdhtFXwc6EkVGd5KDAT+8gV2jhM46y0qEaulgK6Qpbqi1aSh
         ByqYM5v159FUf+LnXxlmzTItYaoZF7leL6Fr1SjXFbNbdQNHkKNfyZ3AB6F84K3qM9zh
         eojg==
X-Gm-Message-State: ACgBeo2Pe5dxdhIzoQq3gNbNoJPDZ/wz08QLvlYI94I00l8QAmgYMiD2
        yt3fxke4D4OTLM2k3ejb/lJp8hpCpuOyyCstP0i5s1WT7k3f5Q==
X-Google-Smtp-Source: AA6agR4l8raOuQK2CppY5jN2dwbZhcb6zQJgquto+Y2BrwuVdXQKVlLlCTe0Zu6/A4D6iwx/cU4OH+XIOypB5uHgvyY=
X-Received: by 2002:a05:6602:26c7:b0:67b:72ef:b87b with SMTP id
 g7-20020a05660226c700b0067b72efb87bmr1867182ioo.175.1660843399015; Thu, 18
 Aug 2022 10:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org> <20220809034517.3867176-5-joel@joelfernandes.org>
In-Reply-To: <20220809034517.3867176-5-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 13:23:07 -0400
Message-ID: <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[Sorry, adding back the CC list]

On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> This is required to prevent callbacks triggering RCU machinery too
> quickly and too often, which adds more power to the system.
>
> When testing, we found that these paths were invoked often when the
> system is not doing anything (screen is ON but otherwise idle).

Unfortunately, I am seeing a slow down in ChromeOS boot performance
after applying this particular patch. It is the first time I could
test ChromeOS boot times with the series since it was hard to find a
ChromeOS device that runs the upstream kernel.

Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
patch? I wonder if the issue is with wake up interaction with the nocb
GP threads.

We ought to disable lazy RCU during boot since it would have little
benefit anyway. But I am also concerned about some deeper problem I
did not catch before.

I'll look into tracing the fs paths to see if I can narrow down what's
causing it. Will also try a newer kernel, I am currently testing on
5.19-rc4.

Thanks,

 - Joel
