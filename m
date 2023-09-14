Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9DDEEAA77
	for <rcu@archiver.kernel.org>; Thu, 14 Sep 2023 21:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjINVxb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjINVxa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Sep 2023 17:53:30 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3154A270C
        for <rcu@vger.kernel.org>; Thu, 14 Sep 2023 14:53:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-792623074edso64331939f.1
        for <rcu@vger.kernel.org>; Thu, 14 Sep 2023 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694728405; x=1695333205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YqUYRk0VbjbOVLpVEKEy8G0UMsuOTQDQx/fvvYIgwrs=;
        b=AqgRkDkJ8YZBnIFGmVWG9c9m9Uc6HkwFNwZWS3NhAO4DvvAloedm3zg6+2+jkoScxT
         lGl/UbF8dM4N9fAW3l9Uf0mXzdpAUqKesAbHYGMbAeMdRHyWhYw0O/EJ0bSZ/ehd/iLh
         0tY9mtmkH2GV+toH88yZ4O6CayVD1NC2N8+RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728405; x=1695333205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqUYRk0VbjbOVLpVEKEy8G0UMsuOTQDQx/fvvYIgwrs=;
        b=ZFSxs53ktJjCqg9FI89T9ih1gnMY6RCocu2f/z00V+NrCSLyrck1R+kUxZoAM6p1ea
         JhEO+alX8tTwNBrVC1C2YixTpzY7ZC59WiLeG9ePsi7M77TofHQ0A/BW6ZRG/6tRgHOd
         sdiRTPk7kyCiQ7jMbmcVwtApexW86k8Zs2bXZh36OIdvQy7RDwoEHCN4yzyJVSCTEx9F
         /HQjsreSm4k9sxnzY3ymQyxgp4xOVh/05Y7qyqqwiAf2wgiVcM8IdTQHOyFvNmbFJ8kT
         xeGgVmLOxFvz3xAI/CCYIEm0RJq31RN1/2Y6TM2clIJS5d+wi1AFPZ2XWrITB3lx6aVN
         6MGw==
X-Gm-Message-State: AOJu0Yw87BguXYS5Kra2PwVGPHlI1zmV3KKlvwh4M8Aax6wg8yH6OyrX
        E4a62KMqD6XRxWsJnry66Dc+T+XUxFjDW5zdUus=
X-Google-Smtp-Source: AGHT+IGij5kXZMY8YJgBD02dyRbryKNfrZzZtAdPS5/rqNs3OhYqW4ySkED5n58ryoMBfVbuj/tjbQ==
X-Received: by 2002:a5e:c80e:0:b0:785:d5d4:9f26 with SMTP id y14-20020a5ec80e000000b00785d5d49f26mr3179192iol.9.1694728405459;
        Thu, 14 Sep 2023 14:53:25 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id h23-20020a05660224d700b007836a9ca101sm671408ioe.22.2023.09.14.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:53:24 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:53:24 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <20230914215324.GA1972295@google.com>
References: <20230910201445.GA1605059@google.com>
 <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com>
 <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
 <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
 <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop>
 <20230914131351.GA2274683@google.com>
 <885bb95b-9068-45f9-ba46-3feb650a3c45@paulmck-laptop>
 <20230914185627.GA2520229@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185627.GA2520229@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 14, 2023 at 06:56:27PM +0000, Joel Fernandes wrote:
> On Thu, Sep 14, 2023 at 08:23:38AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 14, 2023 at 01:13:51PM +0000, Joel Fernandes wrote:
> > > On Thu, Sep 14, 2023 at 04:11:26AM -0700, Paul E. McKenney wrote:
> > > > On Wed, Sep 13, 2023 at 04:30:20PM -0400, Joel Fernandes wrote:
> > > > > On Mon, Sep 11, 2023 at 4:16 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > [..]
> > > > > > > I am digging deeper to see why the rcu_preempt thread cannot be pushed out
> > > > > > > and then I'll also look at why is it being pushed out in the first place.
> > > > > > >
> > > > > > > At least I have a strong repro now running 5 instances of TREE03 in parallel
> > > > > > > for several hours.
> > > > > >
> > > > > > Very good!  Then why not boot with rcutorture.onoff_interval=0 and see if
> > > > > > the problem still occurs?  If yes, then there is definitely some reason
> > > > > > other than CPU hotplug that makes this happen.
> > > > > 
> > > > > Hi Paul,
> > > > > So looks so far like onoff_interval=0 makes the issue disappear. So
> > > > > likely hotplug related. I am ok with doing the cpus_read_lock during
> > > > > boost testing and seeing if that fixes it. If it does, I can move on
> > > > > to the next thing in my backlog.
> > > > > 
> > > > > What do you think? Or should I spend more time root-causing it? It is
> > > > > most like runaway RT threads combined with the CPU hotplug threads,
> > > > > making scheduling of the rcu_preempt thread not happen. But I can't
> > > > > say for sure without more/better tracing (Speaking of better tracing,
> > > > > I am adding core-dump support to rcutorture, but it is not there yet).
> > > > 
> > > > This would not be the first time rcutorture has had trouble with those
> > > > threads, so I am for adding the cpus_read_lock().
> > > > 
> > > > Additional root-causing might be helpful, but then again, you might
> > > > have higher priority things to worry about.  ;-)
> > > 
> > > No worries. Unfortunately putting cpus_read_lock() around the boost test
> > > causes hangs. I tried something like the following [1]. If you have a diff, I can
> > > quickly try something to see if the issue goes away as well.
> > 
> > The other approaches that occur to me are:
> > 
> > 1.	Synchronize with the torture.c CPU-hotplug code.  This is a bit
> > 	tricky as well.
> > 
> > 2.	Rearrange the testing to convert one of the TREE0* scenarios that
> > 	is not in CFLIST (TREE06 or TREE08) to a real-time configuration,
> > 	with boosting but without CPU hotplug.	Then remove boosting
> > 	from TREE04.
> > 
> > Of these, #2 seems most productive.  But is there a better way?
> 
> We could have the gp thread at higher priority for TREE03. What I see
> consistently is that the GP thread gets migrated from CPU M to CPU N only to
> be immediately sent back. Dumping the state showed CPU N is running ksoftirqd
> which is also a rt priority 2.  Making rcu_preempt 3 and ksoftirqd 2 might
> give less of a run-around to rcu_preempt maybe enough to prevent the grace
> period from stalling. I am not sure if this will fix it, but I am running a
> test to see how it goes, will let you know.

That led to a lot of fireworks. :-) I am thinking though, do we really need
to run a boost kthread on all CPUs? I think that might be the root cause
because the boost threads run on all CPUs except perhaps the one dying.

We could run them on just the odd, or even ones and still be able to get
sufficient boost testing. This may be especially important without RT
throttling. I'll go ahead and queue a test like that.

Thoughts?

thanks,

 - Joel

