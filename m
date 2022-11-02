Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A0C4321E
	for <rcu@archiver.kernel.org>; Wed,  2 Nov 2022 18:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKBScn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiKBScl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Nov 2022 14:32:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC85116C;
        Wed,  2 Nov 2022 11:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E287B82426;
        Wed,  2 Nov 2022 18:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E08EC433C1;
        Wed,  2 Nov 2022 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667413958;
        bh=1upx5yZlmjzlwDN2hfo/FCbOeFQhUpRj4FQggZnfjj0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FCM2EhkAixKpjHjemddj6Q8OboFXHBlCFm1MEP4eNDLcwjjEMCbfHQqWUKkn0RQjx
         YhnpV4SdF5x8QISj+vbKMsJRrWL7OQVWt5TBHndXib7EUyPfkEeZ33qajwlEYlUhGq
         NQ6kuXwyZGCCjx25UTRSZip2slV3W2gEODs9nI3KYbKco+DDCKUH+aO+ayUVvuuxBd
         C6Ojp6ppM0WZTs0xDgUNminsp/xEsffIMmwYeon9zSG4AwhLUtPJpEL6pDaAeCq6GY
         xttJ8g7EhrMFlVagTcFzT3L7EAmqhiaFIL42FyI9bRJdXNJ02lQoN0oI+CP0Mh23Dl
         64/fRWJqa+Qxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E26F75C1813; Wed,  2 Nov 2022 11:32:37 -0700 (PDT)
Date:   Wed, 2 Nov 2022 11:32:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <20221102183237.GO5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221029132856.3752018-1-joel@joelfernandes.org>
 <Y2JkoVV3jaVS4y0Q@pc636>
 <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
 <20221102163544.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2KnxKDebPKiqTFZ@pc636>
 <Y2KpMFrtwG+D4YRB@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2KpMFrtwG+D4YRB@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 02, 2022 at 06:30:24PM +0100, Uladzislau Rezki wrote:
> > 
> > to wait for a GP. Or if the poll_state_synchronize_rcu(oldstate)) != 0
> > queue_rcu_work().
> > 
> A small fix. If poll_state_synchronize_rcu(oldstate)) == 0 then
> queue_rcu_work() since a GP is still in progress.

Both get_state_synchronize_rcu() and poll_state_synchronize_rcu()
may be invoked from interrupt handlers.  And from NMI handlers,
for that matter.

							Thanx, Paul
