Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A641FC433DF
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 16:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8783A20B1F
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 16:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFSc6uG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgFPQmL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgFPQmL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 12:42:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F460C06174E
        for <rcu@vger.kernel.org>; Tue, 16 Jun 2020 09:42:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so21489455wrp.2
        for <rcu@vger.kernel.org>; Tue, 16 Jun 2020 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zeIRDbki8eAEIk+7HXowXKMtfqVt+J6tH/sWX1xK3DM=;
        b=JFSc6uG5pmk3/Vr83FZLLOOUFVW5lJtO0nzFRsKhO8JI4hUlwN2CTHoHVRlKGio3NW
         CB8IK304y41nrZf/y717ppqjUIQY1dopLUMdDtbYDw9Wv41lMP3seAlfxmdxme99WSt7
         S3uR+1D3iXjqppFKheQLeV00DkFUbxZFdJoKS6g6CT63kXIwwS++Y4PykU6+jzv/+bPG
         Ba2lAi73WCHjOLwJVajjYGDZ0ehAs7014XwmgB6xfhFOswN5Z2BJQ4+pElwgz1z3tYwr
         s0k7MkKbTdLFkqMf2TvGjBrgvuN6f0Zjtk3tb0nSADee2AC2v6tww20WVJEEEXfpYzJM
         +X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zeIRDbki8eAEIk+7HXowXKMtfqVt+J6tH/sWX1xK3DM=;
        b=NpCb7pMUtYzmdwPN3TQeyDjOAYSbGFlVkhVo9fMjctqCffMzqgtjvmv10pdo5tsZfn
         j/cOQvkE1LMIJjEgRbe6acIVBGhtdHbaPYEVS1L3TweVITgcHmlTqBVvddc0B2/17n92
         V1/6bTrHjzZ94BrnnFUZewWtAvkrQT1yEKIokqCwogJOxcZVciGELBlbAMCJyXowFqXg
         /nrh3cC2ZI6jrwlJEU/inQDATb65IhlxAsCFQnzAUahT0AZqyWzfY/jPlOLl7umCg6g5
         ce9Rwg9y15MOjLn1AaLyGcHgMNoDJfZ0MErfGz0G+mpAmbQWHt3Uvv7OjXfgKvJ8aa69
         YHvQ==
X-Gm-Message-State: AOAM5337qHDV3qNKu6ggc6IRQjuHnTCg0lxVnUOTMc+POIJeomtUD+qS
        0qzfwv5Pu2QC4gOxR1cn7F62qw==
X-Google-Smtp-Source: ABdhPJyTG41jRrlGa2/YUUoJk2nj0unVyz16OOEqPU1c20cxuHIcnqk8fdLm7LrhFd+In7r5PMyAIQ==
X-Received: by 2002:adf:a306:: with SMTP id c6mr3966178wrb.122.1592325728672;
        Tue, 16 Jun 2020 09:42:08 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id t14sm31349034wrb.94.2020.06.16.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:42:07 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:42:02 +0200
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, shuah@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] torture: Pass --kmake-arg to all make invocations
Message-ID: <20200616164202.GA208325@google.com>
References: <20200616094924.159539-1-elver@google.com>
 <20200616160524.GW2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616160524.GW2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 16 2020 at 09:05AM -0700, Paul E. McKenney wrote:

> On Tue, Jun 16, 2020 at 11:49:24AM +0200, Marco Elver wrote:
> > We need to pass the arguments provided to --kmake-arg to all make
> > invocations. In particular, the make invocations generating the configs
> > need to see the final make arguments, e.g. if config variables depend on
> > particular variables that are passed to make.
> > 
> > For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
> > CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
> > compiler that supports KCSAN.
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Queued and pushed, thank you!
> 
> Would the following patch make sense, at least until such time
> as some other compiler supports KCSAN?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 88bcaa730b6d40ddf69b09ed6f0a14803d087d99
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 16 09:02:34 2020 -0700
> 
>     torture: Make --kcsan default to using Clang 11
>     
>     Currently, Clang 11 is the only compiler that can support KCSAN.
>     Therefore, as a convenience to the KCSAN user, this commit causes
>     --kcsan to specify Clang 11 unless a "CC=" argument was already
>     specified via the --kmake-arg argument.

As soon as more compilers support KCSAN (e.g. clang-12, etc...) we run
the risk of actually inconveniencing ourselves more because then we
really need to say '--kmake-arg CC=clang-1X' to not use the old
compiler. Or revert this in time.

My command-line looks more like this right now:

	kvm.sh ... --kmake-arg "CC="${HOME}/local/<gcc-or-clang>-11.kcsan/local/bin/<gcc-or-clang>" ...

I think the safer alternative would be to error if CONFIG_KCSAN=y is not
in the config, and simply suggest "Did you forget to switch your
compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?" (of course, a
'gcc' in $PATH that supports KCSAN would also be fine -- see below).
Eventually, when the default compilers support KCSAN, this will resolve
itself gracefully.

Also, I'm going to send a series later this week to re-enable GCC
support. ;-)

Thanks,
-- Marco
