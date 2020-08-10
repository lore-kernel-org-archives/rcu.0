Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A28EC433E0
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 20:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB11D2083B
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 20:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SEZ+p9rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHJUJC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgHJUJC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 16:09:02 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC5C061756
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2020 13:09:01 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id o2so4883041qvk.6
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2020 13:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c1Pp3HJilWX98WYnzlWN6snq7yjH2XOyaaLUif0NzbY=;
        b=SEZ+p9rpogxE5Z/13MdTyrdyD4iHL6NaXAGUFwzGNWgPhsnVCFapUfN3DmBGLregXB
         wDPKc3awJbZVOH32URvh9tCOitpx6AIyvQmeBAW3zA2xLML/k7ErwAyl/Ku6IuveKVOG
         gYqV3tRBF1g3ySREWZQhnbNYavycPgD1khq1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c1Pp3HJilWX98WYnzlWN6snq7yjH2XOyaaLUif0NzbY=;
        b=XJcbPUQV3mdQK96/Nq6YJT4kXpu9fR+eerN05cHjouZBunGlLwsyXBG+4Dt1Q8NRss
         gWU2cS0sOJtrBPwhnHWZZodQ0bd46OYXHcMvhxbcPfRKRD5eBGopQ77U6ILmzkC41Iqr
         JMUBvIpMlTkUnIfGpx6vduVak13y7WEH5/HYp5iZLVe4WtedRkZgLlsiXQ+8ObDJuJal
         tZIwXQwUn7+M2DKNSAMWBVyBhXUSB2INuBnm0kXILaD6qOGsvnLRjjakWGktd2ZyJcju
         5Qv80P7t2APUl2SdNPXzocACkMUzGLQ8ZuAnfiw2F0eGu6DTXO/pJbM3QDjJBzgcDmQm
         DOqA==
X-Gm-Message-State: AOAM530byWys8fv4q9LiKOk8W2g6wFfmtPALMsgmPB59DxcBcgE7AK3o
        nRhhIPukP9mTX4PgGRO04U7DAw==
X-Google-Smtp-Source: ABdhPJz31KoiXIJXJurztNsWZFNUqoLcEKdS2ak1FA5qdxrY0BKgTMKtmxR5Pg3EmnzNSoJ3nMV8oQ==
X-Received: by 2002:ad4:54ce:: with SMTP id j14mr30715621qvx.185.1597090140977;
        Mon, 10 Aug 2020 13:09:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id j61sm16454006qtd.52.2020.08.10.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 13:08:59 -0700 (PDT)
Date:   Mon, 10 Aug 2020 16:08:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Johan =?iso-8859-1?B?S2729nM=?= <jknoos@google.com>,
        Gregory Rose <gvrose8192@gmail.com>, bugs@openvswitch.org,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [ovs-discuss] Double free in recent kernels after memleak fix
Message-ID: <20200810200859.GF2865655@google.com>
References: <CA+Sh73MJhqs7PBk6OV2AhzVjYvE1foUQUnwP5DwWR44LHZRZ9w@mail.gmail.com>
 <58be64c5-9ae4-95ff-629e-f55e47ff020b@gmail.com>
 <CA+Sh73NeNr+UNZYDfD1nHUXCY-P8mT1vJdm0cEY4MPwo_0PtzQ@mail.gmail.com>
 <CAEXW_YSSL5+_DjtrYpFp35kGrem782nBF6HuVbgWJ_H3=jeX4A@mail.gmail.com>
 <20200807222015.GZ4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200807222015.GZ4295@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 07, 2020 at 03:20:15PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 07, 2020 at 04:47:56PM -0400, Joel Fernandes wrote:
> > Hi,
> > Adding more of us working on RCU as well. Johan from another team at
> > Google discovered a likely issue in openswitch, details below:
> > 
> > On Fri, Aug 7, 2020 at 11:32 AM Johan Knöös <jknoos@google.com> wrote:
> > >
> > > On Tue, Aug 4, 2020 at 8:52 AM Gregory Rose <gvrose8192@gmail.com> wrote:
> > > >
> > > >
> > > >
> > > > On 8/3/2020 12:01 PM, Johan Knöös via discuss wrote:
> > > > > Hi Open vSwitch contributors,
> > > > >
> > > > > We have found openvswitch is causing double-freeing of memory. The
> > > > > issue was not present in kernel version 5.5.17 but is present in
> > > > > 5.6.14 and newer kernels.
> > > > >
> > > > > After reverting the RCU commits below for debugging, enabling
> > > > > slub_debug, lockdep, and KASAN, we see the warnings at the end of this
> > > > > email in the kernel log (the last one shows the double-free). When I
> > > > > revert 50b0e61b32ee890a75b4377d5fbe770a86d6a4c1 ("net: openvswitch:
> > > > > fix possible memleak on destroy flow-table"), the symptoms disappear.
> > > > > While I have a reliable way to reproduce the issue, I unfortunately
> > > > > don't yet have a process that's amenable to sharing. Please take a
> > > > > look.
> > > > >
> > > > > 189a6883dcf7 rcu: Remove kfree_call_rcu_nobatch()
> > > > > 77a40f97030b rcu: Remove kfree_rcu() special casing and lazy-callback handling
> > > > > e99637becb2e rcu: Add support for debug_objects debugging for kfree_rcu()
> > > > > 0392bebebf26 rcu: Add multiple in-flight batches of kfree_rcu() work
> > > > > 569d767087ef rcu: Make kfree_rcu() use a non-atomic ->monitor_todo
> > > > > a35d16905efc rcu: Add basic support for kfree_rcu() batching
> > 
> > Note that these reverts were only for testing the same code, because
> > he was testing 2 different kernel versions. One of them did not have
> > this set. So I asked him to revert. There's no known bug in the
> > reverted code itself. But somehow these patches do make it harder for
> > him to reproduce the issue.
> 
> Perhaps they adjust timing?

Yes that could be it. In my testing (which is unrelated to OVS), the issue
happens only with TREE02. I can reproduce the issue in [1] on just boot-up of
TREE02.

I could have screwed up something in my segcblist count patch, any hints
would be great. I'll dig more into it as well.

> > 
> > But then again, I have not heard reports of this warning firing. Paul,
> > has this come to your radar recently?
> 
> I have not seen any recent WARNs in rcu_do_batch().  I am guessing that
> this is one of the last two in that function?
> 
> If so, have you tried using CONFIG_DEBUG_OBJECTS_RCU_HEAD=y?  That Kconfig
> option is designed to help locate double frees via RCU.

Yes true, kfree_rcu() also has support for this. Jonathan, did you get a
chance to try this out in your failure scenario?

thanks,

 - Joel

[1] https://lore.kernel.org/lkml/20200720005334.GC19262@shao2-debian/
