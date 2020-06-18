Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD792C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8517C20734
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 21:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592516068;
	bh=gCSQ8dORA8i8XQTpX08qSMBD4GVasZLFb37hDSiHIQE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vvPWDzxRbCzwHK/yOt6j2YzPgVNDCK06o2h+/XCm5XAYp657M19Ck20F43KsOi0ti
	 O98BCfod2A1UdsHdS3ksxSn+2a8zd2ywb1pz4Rt4PPYhP8ed+JCEK00XccCOpgFSTk
	 mlVhuJ/pO2VulgA29d25H2c7op46JejoXlByJlpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbgFRVe2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731031AbgFRVe2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 17:34:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F67206F1;
        Thu, 18 Jun 2020 21:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592516067;
        bh=gCSQ8dORA8i8XQTpX08qSMBD4GVasZLFb37hDSiHIQE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HD4RqH/4WEqnIBTR6cJ3TtCcV0qRrlPsOa6mKKso4feoO1utjqAMvec/NHV2VCVBv
         pR4jkroccINaphqCV2+vIH4W+bLGz0hJViaeHTPhf/ULdzMKPau4SCNRL+8GGlK6Iu
         wuBvu/g4Xo1m+aCTPdoFrIKD1BgwLWU/6uoxL+5o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 58A03352264E; Thu, 18 Jun 2020 14:34:27 -0700 (PDT)
Date:   Thu, 18 Jun 2020 14:34:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618213427.GV2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
 <20200618203557.GB16976@pc636>
 <20200618203821.GU8681@bombadil.infradead.org>
 <20200618211709.GA17263@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618211709.GA17263@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 11:17:09PM +0200, Uladzislau Rezki wrote:
> > > <snip>
> > >     trace_rcu_invoke_kfree_bulk_callback(
> > >         rcu_state.name, bkvhead[i]->nr_records,
> > >             bkvhead[i]->records);
> > >     if (i == 0)
> > >         kfree_bulk(bkvhead[i]->nr_records,
> > >             bkvhead[i]->records);
> > >     else
> > >         vfree_bulk(bkvhead[i]->nr_records,
> > >             bkvhead[i]->records);
> > > <snip>
> > > 
> > > Matthew, what is your thought?
> > 
> > That was my thinking too.  If we had a kvfree_bulk(), I would expect it to
> > handle a mixture of vfree and kfree, but you've segregated them already.
> > So I think this is better.
> >
> Yes, the segregation is done. Having vfree_bulk() is enough then.
> We are on the same page :)

Very good.  When does kfree_rcu() and friends move out of kernel/rcu?

							Thanx, Paul
