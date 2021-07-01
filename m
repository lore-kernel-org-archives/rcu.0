Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77642C11F64
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5291361406
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 18:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGASmI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhGASmI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Jul 2021 14:42:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ED9C061762
        for <rcu@vger.kernel.org>; Thu,  1 Jul 2021 11:39:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu19so13521442lfb.9
        for <rcu@vger.kernel.org>; Thu, 01 Jul 2021 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wy+ZXMjxNtxPpGZ1xiQokaQAhxABfkzMXnmZrLuAd2k=;
        b=oE+b7JZb3R7ghOs1hcGm7jRkwcaElQXmYvBELV0sQHhTAi1aHn0bAswArC7OgttWZD
         UHe12yhfWvfAl8/LPyFDIQx3fOhtV95vj2hSDebV0tSghrihKh6WWVyxaqKrW+KeyQWf
         4CD1FrngH7rEYUbpXMgmV6qzm6hOzbO6qNwwz2XGBvI08g7sRlnuQ95EWjSkm1jm4duo
         AyRCreHlgxi3yoKHjD0N10hGluPKGjjyo95HEI8UDXPK9PNEBDD5w2WFE3n1gUFKk3fC
         U0j4GexyC8p6amoaVVa1bQnApp9UI+k1x3Co4VmjuUXdgDTJKwuDPFpuYjTmrSKyOrQb
         c5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wy+ZXMjxNtxPpGZ1xiQokaQAhxABfkzMXnmZrLuAd2k=;
        b=uMZ+dLGxjfBXqFQpkZQWN3QSYLp9rafJQAkE8IdJaM0q1PSDBq9ToenaVS9gs0CLb8
         JoXcrgR8QiQJAhiMNVybmb5j83+X7njI9IJZcU3MfE3MuYh87sufdUQ1ugg+lbxDtfrS
         Qdf7jxkwhdD4bhvQhjE2BeF2CoZPA5VzLmRzloPPNWy8MmlN0KiLwneNdeU1CK30cnn1
         2zZ1Xyqu3FqqfyAdjMxGMmRSrlHySnQnwrPdg1wsfC2dc+5ZqhWlF/KouVp/C83jNvCY
         BTfSQ5ohhTIb7uxgWnzbdoFOsE8UZfrlPMv3ciqPjkPExZZQ/IpOmyNlv7bAISuvCL6g
         MC2g==
X-Gm-Message-State: AOAM531HzqM5BohaYDsgz1GcQhsTSCcWd/ZWc4tI9KDMeFZzgk+I+UmU
        CfooFTHG3FJI6EckrL+x+gQ=
X-Google-Smtp-Source: ABdhPJzhsCk3L3Ed8ri1cKUpEb2k80ZZTC23vvFJ97gvlA6m4HvcsB53VdbM5jbET6tmCwVPshyBgg==
X-Received: by 2002:ac2:44b9:: with SMTP id c25mr727475lfm.621.1625164775303;
        Thu, 01 Jul 2021 11:39:35 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n6sm44068lfi.2.2021.07.01.11.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:39:34 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 1 Jul 2021 20:39:33 +0200
To:     Neeraj Upadhyay <neeraju@codeaurora.org>, paulmck@kernel.org
Cc:     paulmck@kernel.org, Liu Song <fishland@aliyun.com>,
        liu.song11@zte.com.cn, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Use per_cpu_ptr to get the pointer of per_cpu
 variable
Message-ID: <20210701183933.GA1948@pc638.lan>
References: <20210630140802.39138-1-fishland@aliyun.com>
 <85a49682-a196-65e5-b0a4-52f51b76626c@codeaurora.org>
 <20210701163115.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <bb788228-9756-2ee9-f11c-eae133c34593@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb788228-9756-2ee9-f11c-eae133c34593@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 01, 2021 at 10:35:43PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 7/1/2021 10:01 PM, Paul E. McKenney wrote:
> > On Thu, Jul 01, 2021 at 08:24:32PM +0530, Neeraj Upadhyay wrote:
> > > 
> > > 
> > > On 6/30/2021 7:38 PM, Liu Song wrote:
> > > > From: Liu Song <liu.song11@zte.com.cn>
> > > > 
> > > > In rcu, most codes have used per_cpu_ptr to obtain per_cpu variable
> > > > pointers. This patch adjusts a few codes that have not done so.
> > > > 
> > > 
> > > Minor: Can we also add below statement?
> > > "This patch doesn't introduce any functional change."
> > > 
> > > > Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> > 
> > Applied with the usual wordsmithing, including adding words to this
> > effect, so thank you all!  I removed the obsolete chunk that Neeraj
> > pointed out as well.
> > 
> > Please take a look and check to see if all is well.
> > 
> 
> Looks good to me
> 
Same to me. Looks good.

There are two dots though in the commit message: "change.." :)

--
Vlad Rezki
