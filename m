Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18425C433FE
	for <rcu@archiver.kernel.org>; Mon,  9 May 2022 15:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiEIQCt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 May 2022 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbiEIQCs (ORCPT <rfc822;rcu@vger>);
        Mon, 9 May 2022 12:02:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19482D9EE0
        for <rcu@vger.kernel.org>; Mon,  9 May 2022 08:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEEF612C6
        for <rcu@vger.kernel.org>; Mon,  9 May 2022 15:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CEFC385AE;
        Mon,  9 May 2022 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111933;
        bh=x9jqIZC8Aqtho5Apy6mOXFG0+9Jy0mtp/WTd7h3Ez08=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hV9CwUphjyGC89R2VyVXyDVFbvPWSYUbLArfVOSrIRpVdmNVEQaw6ofLd/nKLk4Kk
         uqP2eIc6AdTBeBdzCS65EDHr/eexkHthfCwV7RRJfxlUUhfU3cSI+SiPBn3dx1ZepB
         scRT2hRMayjhoKnGNl2b47XWnW6dLTZzWasswE2Ht+Ptx2B8WAtNbvLwX/5B4k55Lt
         jOdQ8TC5CW6hYeToRTtaWpDoxQi1GwmDVzAq9pk8lJ209Q5ZZdH6mU9uXzuzpyT2BL
         7Ef/R3HmcQAgSlkz8o8uPaX7qGlBVLyrVyY05zms/n4hpNsxFiVhGExfUmj7mIl5TS
         3NX/8gY4CsFaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2ABBF5C00B8; Mon,  9 May 2022 08:58:53 -0700 (PDT)
Date:   Mon, 9 May 2022 08:58:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, kernel.org@paulmck-ThinkPad-P17-Gen-1
Subject: tools/rcu
Message-ID: <20220509155853.GA94897@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Joel!

Just following up from your tweet.  There is a tools/rcu that is likely
to be the best place for scripts and tools that monitory RCU.

						Thanx, Paul
