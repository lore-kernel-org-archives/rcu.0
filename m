Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CF7C43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BCE20776
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585754892;
	bh=SqTugHaQo6OhFJqHNlJ7yjISYWCEXjX7tfk3f8ejDsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XGZJo5y1It8pB/2E6h4tWLgh+IMetTgSrEOICCNVzYWtxH58qCNXr2g5rZYKUttkr
	 WW1w0AfphwYdawzU60SdvmrVbvjXJ4Xj8uQIGZvdN+iEkQFVV+qPYPAzId1zqSmXvp
	 bK7pw3wBDpEZEKBlV/fF9STec4r7Smfo2gsi9xnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbgDAP2L (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:28:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52975 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbgDAP2L (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 11:28:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id t8so136270wmi.2;
        Wed, 01 Apr 2020 08:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vaNO/Vf7ZJ182A/f/+CJjHbWmzGxcMlfGPY3Ppq/aE=;
        b=jLrZyMVUR1Lso+DPL5aJbmbtLMM98dF7I6Yd6LrfMEkgNZJH91HoqY/yKwke18qV8a
         TPhkoB8P77pDYhe+2WIiY7u+YkQZC+zG4mwS+eT+HHYxmjo2nxwUQJmcAirPrNr291Uz
         a/qq5ioIahpZwD497PyCLR2nfIuiHoAnLUlR49vu9YgqcjTYO7w/AVI3qgk/56Jap637
         LdntDQYu9qS91bEPLUE6nSpbJSQiCvWh3WKQuPsmNrbR1WAOZ0dOaMYtPZiP+J7nQDAz
         8uIzeFp2RRQ+k9F/JlrAxgWq2eC69FsEBwCGSYrrebAePHAYR/UPvdZoBuCSvDchxW5/
         4BSw==
X-Gm-Message-State: AGi0PuaWZi1LqthrGDtkfhyJ8ht0kwUCMhczSdAICNAGLnPKuprqcl2q
        cmaEiAyYWxdyRe0BWuguNaA=
X-Google-Smtp-Source: APiQypKRGw54qCqRgzbgwcP4pMmETIbqZke35Pmh0cO/xsnw3kjzHX9FNr57yLo1BlH86iJ+mTJVxQ==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr2522021wmi.178.1585754889604;
        Wed, 01 Apr 2020 08:28:09 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id q8sm3787379wrc.8.2020.04.01.08.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:28:08 -0700 (PDT)
Date:   Wed, 1 Apr 2020 17:28:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401152805.GN22681@dhcp22.suse.cz>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
 <20200401070958.GB22681@dhcp22.suse.cz>
 <20200401123230.GB32593@pc636>
 <20200401125503.GJ22681@dhcp22.suse.cz>
 <20200401130816.GA1320@pc636>
 <20200401131528.GK22681@dhcp22.suse.cz>
 <20200401132258.GA1953@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401132258.GA1953@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 01-04-20 15:22:58, Uladzislau Rezki wrote:
> > > We call it from atomic context, so we can not sleep, also we do not have
> > > any existing context coming from the caller. I see that GFP_ATOMIC is high-level
> > > flag and is differ from __GFP_ATOMIC. It is defined as:
> > > 
> > > #define GFP_ATOMIC (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
> > > 
> > > so basically we would like to have __GFP_KSWAPD_RECLAIM that is included in it,
> > > because it will also help in case of high memory pressure and wake-up kswapd to
> > > reclaim memory.
> > > 
> > > We also can extract:
> > > 
> > > __GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL | __GFP_KSWAPD_RECLAIM
> > > 
> > > but that is longer then
> > > 
> > > GFP_ATMOC |  __GFP_RETRY_MAYFAIL
> > 
> > OK, if you are always in the atomic context then GFP_ATOMIC is
> > sufficient. __GFP_RETRY_MAYFAIL will make no difference for allocations
> > which do not reclaim (and thus not retry). Sorry this was not clear to
> > me from the previous description.
> > 
> Ahh. OK. Then adding __GFP_RETRY_MAYFAIL to GFP_ATOMIC will not make any effect.
> 
> Thank you for your explanation!

Welcome. I wish all those gfp flags were really clear but I fully
understand that people who are not working with MM regurarly might find
it confusing. Btw. have __GFP_RETRY_MAYFAIL is documented in gfp.h and
it is documented as the reclaim modifier which should imply that it has
no effect when the reclaim is not allowed which is the case for any non
sleeping allocation. If that relation was not immediately obvious then I
think we need to make it explicit. Would you find it useful?

E.g.

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e3ab1c0d9140..8f09cefdfa7b 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -127,6 +127,8 @@ struct vm_area_struct;
  *
  * Reclaim modifiers
  * ~~~~~~~~~~~~~~~~~
+ * Please note that all the folloging flags are only applicable to sleepable
+ * allocations (e.g. %GFP_NOWAIT and %GFP_ATOMIC will ignore them).
  *
  * %__GFP_IO can start physical IO.
  *
-- 
Michal Hocko
SUSE Labs
