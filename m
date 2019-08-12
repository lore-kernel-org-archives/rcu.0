Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F6FC31E40
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C806F20684
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ek/YpqOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfHLNMh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:12:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38604 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfHLNMh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Aug 2019 09:12:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id o70so4333315pfg.5
        for <rcu@vger.kernel.org>; Mon, 12 Aug 2019 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gZSffQw3OgyBMCQLYW8xDq5QOYfXWIqDSRNv2nk7GfU=;
        b=ek/YpqOY0WfmZwQaIvRr2fO13Osf/wvmApdCKlxNVykMRGuuRJ4Cqa4jzTxjUTljBc
         8upRaRvO6GHin7ENipsnd7Tc49lXBcg/MJRTtnDTyVv8lmI2wQC2udk3QW/Fb/Nm0/HH
         XSO2eX8O3iHPdg2GZ7HiH+bAPRXlDN1a2Shi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gZSffQw3OgyBMCQLYW8xDq5QOYfXWIqDSRNv2nk7GfU=;
        b=UpPOBdHTa5sL9RwYyGckFleUGZYqCEn81bE9fE9nuz2bdVGTwhwYv0FVGi+rI8suOe
         JFbb/0Jwb/+q27UEY8SWaNyB91Q/9/0Mty7wRLSp2vz++utUFdsJr2WP5IJFT1gBBbWe
         S9EL1Yhc4HhqOLbsW2O3U3w4ou9E5bITaEPYGZY1NdV78BAqdeh/RDhhAAaQzMkJBgIq
         04/ynTL+5W5/LAT4UXgs3OjjMkdo6PQBQfTOCGrCiLT/Yp7rkwYkFeTbw78Z8rM8qBjf
         7mYxHyU764mEq9aYKSJVN0+ydYIH4LtmJQt2xK5Z+fxwI3HKnZdSCtT3RablqWjS9Dht
         GQjA==
X-Gm-Message-State: APjAAAW2TddP4gf2Vyt7oywkdT/NIES3K3PgX9wKBedcw8X15fyM8TTL
        t5hXcbecZ6KxuGRrudHuHE2NuQ==
X-Google-Smtp-Source: APXvYqwlJHETcT4miXiMrHWr5YjVtRG74vvBQaTZLMUny9dn5o2sdVc2BWmJxX+t/j0RDSN5FNn3LQ==
X-Received: by 2002:a62:1858:: with SMTP id 85mr11758185pfy.120.1565615556767;
        Mon, 12 Aug 2019 06:12:36 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k64sm83531977pge.65.2019.08.12.06.12.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 06:12:35 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:12:34 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rao Shoaib <rao.shoaib@oracle.com>, kernel-team@android.com,
        kernel-team <kernel-team@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190812131234.GC27552@google.com>
References: <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <CANrsvRPU_u6oKpjZ1368Evto+1hGboNYeOuMdbdzaOfXhSO=5g@mail.gmail.com>
 <20190808180916.GP28441@linux.ibm.com>
 <20190811083626.GA9486@X58A-UD3R>
 <20190811084950.GB9486@X58A-UD3R>
 <20190811234939.GC28441@linux.ibm.com>
 <20190812101052.GA10478@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812101052.GA10478@X58A-UD3R>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 07:10:52PM +0900, Byungchul Park wrote:
> On Sun, Aug 11, 2019 at 04:49:39PM -0700, Paul E. McKenney wrote:
> > Maybe.  Note well that I said "potential issue".  When I checked a few
> > years ago, none of the uses of rcu_barrier() cared about kfree_rcu().
> > They cared instead about call_rcu() callbacks that accessed code or data
> > that was going to disappear soon, for example, due to module unload or
> > filesystem unmount.
> > 
> > So it -might- be that rcu_barrier() can stay as it is, but with changes
> > as needed to documentation.

Right, we should update the docs. Byungchul, do you mind sending a patch that
documents the rcu_barrier() behavior?

> > It also -might- be, maybe now or maybe some time in the future, that
> > there will need to be a kfree_rcu_barrier() or some such.  But if so,
> > let's not create it until it is needed.  For one thing, it is reasonably
> > likely that something other than a kfree_rcu_barrier() would really
> > be what was needed.  After all, the main point would be to make sure
> > that the old memory really was freed before allocating new memory.
> 
> Now I fully understand what you meant thanks to you. Thank you for
> explaining it in detail.
> 
> > But if the system had ample memory, why wait?  In that case you don't
> > really need to wait for all the old memory to be freed, but rather for
> > sufficient memory to be available for allocation.
> 
> Agree. Totally make sense.

Agreed, all makes sense.

thanks,

 - Joel

[snip]
