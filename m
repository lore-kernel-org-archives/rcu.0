Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE92CA0EC3
	for <rcu@archiver.kernel.org>; Tue, 12 Sep 2023 09:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjILJwv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Sep 2023 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjILJwv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Sep 2023 05:52:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DB31BB
        for <rcu@vger.kernel.org>; Tue, 12 Sep 2023 02:52:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177CAC433C7;
        Tue, 12 Sep 2023 09:52:45 +0000 (UTC)
Date:   Tue, 12 Sep 2023 10:52:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Paasch <cpaasch@apple.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <ZQA064908T5nngcc@arm.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com>
 <ZPi1LvrcGcSKBLqR@arm.com>
 <CAEXW_YTxLRAKCpFdKOdegj0gZdBb0OH+BnJf9FGTGfPtwiPkiw@mail.gmail.com>
 <26A7E7B0-8B40-465C-9FC6-6F3D6529A591@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26A7E7B0-8B40-465C-9FC6-6F3D6529A591@apple.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 11, 2023 at 10:41:15AM -0700, Christoph Paasch wrote:
> On Sep 10, 2023, at 4:10 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Wed, Sep 6, 2023 at 1:21 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> On Tue, Sep 05, 2023 at 02:22:13PM -0700, Christoph Paasch wrote:
> > [..]
> >>> If you have an updated patch, let me know. I can test it.
> >> 
> >> I sent it in reply to Joel.
> > 
> > Just checking if you got a chance to try Catalin's patch?
> 
> sorry for the delay! Yes, I tested it and it works!

Great, thanks!

-- 
Catalin
