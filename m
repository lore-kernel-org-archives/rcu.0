Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893D3C2D0EB
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 17:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9202073B
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 17:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki7vetEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgC3Rnz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:43:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39855 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgC3Rny (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 13:43:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so19050105ljn.6;
        Mon, 30 Mar 2020 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQr64dkZ4eCLxEsitWkiuUGekxkmYwIH1iRCbGD/zRE=;
        b=ki7vetEue1PM2ZQmU/Tea9XEuoxngbiguFMhJAvBVcAG6QoFY3rOaRivwDk8flcvW6
         vbZxcwjLOth6VX4MBq2Hub77pIR3wU/EHdwvgoKpAQOvNnNEtVOxHiYYcllHgnEBx9Rk
         X9CwMYKEcDSKIc90c/6aK0a4CqjhTOz9/FCC6H1Rb4qAZXsXGAyX91cSmSGJ2aIC/HlU
         E4ywKyF5VyQ7jas2D6eOj0TfDR/vycW3G3CNfpdBKhi+qhQz6rI6dHRBO/b3BRZ5B2uX
         btmCkGjBA++krOdk6xGY9kutIEsgnypzIFFnbCGWFvgUhsvkJkYZ40PUaFU7I+m2P100
         LEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQr64dkZ4eCLxEsitWkiuUGekxkmYwIH1iRCbGD/zRE=;
        b=UeDHc20oKam4Fp3HIxAN6zCDOw1zTVohLDargPx+UzCu2anP/q6TqaMRi8HCAwCYIo
         YokTgMCNp5IUGHiuiLg/5jMeZ8j38x626FnoWiEqKh2UXReDKAa9nVLY6UKqEjMgF2yB
         4bH1T+OgB90+sE28MW+KBstNag/lJTUFzp1gJqNZBKYyXF8+neiynEuRyN2cfJy0sNXK
         ZRH2rzu/+VjZYdF+EPUEbuFCZHnYzycvOThJAD9uMOG+uG/TS2T+gxOLJMaYyb1V5XYP
         JNfngJ3l9wgH+Yv26SPLRpJB4mq3Z9Npm57sl90Pkp0TH0AWwLQIbhDDrD38YmCCPsOJ
         x3vA==
X-Gm-Message-State: AGi0PuZVXupeTSdZp4e4nk+3Rag2MRKY4Ru3HSaEW+tIgLJJFgGUZY3e
        Qo3LkPyWIphnJ6Qfio7+cxI=
X-Google-Smtp-Source: APiQypIS7HZGHphIkSiBweV8/quFCZ7OY75pszvwMH2lYCVmB+Uz9TamZO1WySO8lan1VoTgkJnfXA==
X-Received: by 2002:a2e:888e:: with SMTP id k14mr7916833lji.4.1585590231852;
        Mon, 30 Mar 2020 10:43:51 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 15sm8110742lfb.56.2020.03.30.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:43:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 30 Mar 2020 19:43:38 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 10/18] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200330174338.GA3690@pc636>
References: <20200330023248.164994-11-joel@joelfernandes.org>
 <202003301715.9gMSa9Ca%lkp@intel.com>
 <20200330152951.GA2553@pc636>
 <20200330153149.GE22483@bombadil.infradead.org>
 <20200330153702.GK19865@paulmck-ThinkPad-P72>
 <20200330171606.GA166021@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330171606.GA166021@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 30, 2020 at 01:16:06PM -0400, Joel Fernandes wrote:
> On Mon, Mar 30, 2020 at 08:37:02AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 30, 2020 at 08:31:49AM -0700, Matthew Wilcox wrote:
> > > On Mon, Mar 30, 2020 at 05:29:51PM +0200, Uladzislau Rezki wrote:
> > > > Hello, Joel.
> > > > 
> > > > Sent out the patch fixing build error.
> > > 
> > > ... where?  It didn't get cc'd to linux-mm?
> > 
> > The kbuild test robot complained.  Prior than the build error, the
> > patch didn't seem all that relevant to linux-mm.  ;-)
> 
> I asked the preprocessor to tell me why I didn't hit this in my tree. Seems
> it because vmalloc.h is included in my tree through the following includes. 
> 
Same to me, i did not manage to hit that build error.

--
Vlad Rezki
