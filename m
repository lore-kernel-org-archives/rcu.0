Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D7C43334
	for <rcu@archiver.kernel.org>; Thu, 16 Jun 2022 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiFPQ0s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiFPQ0r (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jun 2022 12:26:47 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF092ED4F
        for <rcu@vger.kernel.org>; Thu, 16 Jun 2022 09:26:47 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h7so1269572ila.10
        for <rcu@vger.kernel.org>; Thu, 16 Jun 2022 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjbj3z9ler90/7DuSJLAGsPx/mKMIDw4fDilnDC5Spk=;
        b=isXgpX78RqnhADqvB1+slYRlPjEecG/XX+kHV5g/jGPRA2b5cIOS/dfjgn5r4/SyJF
         QztB5g/nR7WxN9+pV89Mt76Z9KNAWCgb/BSGWD7g6RJIsdpDqmUHGc+GWd/Udw0bU4TP
         MPLMDojU9Cg6Cz6zlPe9Mb+iE0Dq5UnvPhuRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjbj3z9ler90/7DuSJLAGsPx/mKMIDw4fDilnDC5Spk=;
        b=cez8ptWFuoKJxGhNj93+zI10uvO8QczNwMPfuILkHYbWfBpVFxdJh/dS9gPr8i6dLO
         a5Fr90JI1khx69GshdhtkH7jgtPkTHmhbVY6Cj2NdP2i4mn2ySDlhxqzljHgieY7K0a2
         MHOZOk0NQLUWY6PhVsuaffInPv3QkeQlfpGAYCClf1qG3FF/Cwkz5e2V7KVa2HJe++ZE
         7D+uSgr1EXtuXrD/ukZ8Z4jcCZSdNe4z8VhEmIlawTiTKYvdmmkmopi3QyYlhHUbLzUc
         9gd8KWkg5twxdBCIAXXk0fmyCuDeqVcv1p/RQY8HGSvQTq95PE3GnzDdk/4QoF71GiGl
         biLQ==
X-Gm-Message-State: AJIora91MYKL3sT0cOJmtpZ2BE1aSRHKVOk13a6dNQGBwv4yYIOCiKCS
        l6sPu08JtSNQG+U6AYXmh7SmjgKpWO8dA2LacmWKog==
X-Google-Smtp-Source: AGRyM1uFo6bqBWuexzNO/GXyEle8b3eb0MW2CVyNOxmL3KbEjwRH/KThWbcE6coxLdGeLwUG1OEfUK99jGSd5kZxh0Y=
X-Received: by 2002:a92:603:0:b0:2d8:d6e0:1363 with SMTP id
 x3-20020a920603000000b002d8d6e01363mr1151783ilg.307.1655396806744; Thu, 16
 Jun 2022 09:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <YqeHp0Zmm512x5nx@google.com> <20220613224843.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220613224843.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Jun 2022 12:26:35 -0400
Message-ID: <CAEXW_YQWeDLNSw9MhPum+ABB2tzDVoLvg1KSxhnaKdhS7EsZNA@mail.gmail.com>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 13, 2022 at 6:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 06:53:27PM +0000, Joel Fernandes wrote:
> > On Thu, May 12, 2022 at 03:04:28AM +0000, Joel Fernandes (Google) wrote:
> > > Hello!
> > > Please find the proof of concept version of call_rcu_lazy() attached. This
> > > gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> > > Rushikesh Kadam from Intel for investigating it with me.
> >
> > Just a status update, we're reworking this code to use the bypass lists which
> > takes care of a lot of corner cases. I've had to make changes the the rcuog
> > thread code to handle wakes up a bit differently and such. Initial testing is
> > looking good. Currently working on the early-flushing of the lazy CBs based
> > on memory pressure.
> >
> > Should be hopefully sending v2 soon!
>
> Looking forward to seeing it!

Looks like rebasing on paul's dev is needed for me to even apply test
on our downstream kernels.  Why you ask? Because our downstream folks
are indeed using upstream 5.19-rc3. =) Finally rebase succeeded and
now I can test lazy bypass downstream before sending out the next
RFC...

 - Joel
