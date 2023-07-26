Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2333C001DF
	for <rcu@archiver.kernel.org>; Wed, 26 Jul 2023 21:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGZVMk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGZVMk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jul 2023 17:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1521BE8;
        Wed, 26 Jul 2023 14:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 119F061CC6;
        Wed, 26 Jul 2023 21:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AADFC433C8;
        Wed, 26 Jul 2023 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690405956;
        bh=i828POzSbl7BsPa5p4K6TyQnc2ZswTp17QKbFbtTbdE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hb2ZFJ6c4tp11ai6lX9YvQwRitMYYXguiTRs4knH/MWLlvRUiZ2sQzFrQuuFwQI5d
         TjjWE2FQf1TWcAJV0FSuu6ajjE/NwyIXhQtKMAheCYaajNjccHCRZmEdgpTsrwpmbw
         Aq+eQtnOtNXRuEjtfXnOjop4RvkVg9FeWxuX8CRuURCv2ELQbv24kzJiVHQi8C9v9H
         bgW3n/he3i/q2SuDEpc4Wb7U9mhECEo99eTnjmm5uVC+fZ6dbDH/MYLDYjSvRuSCX+
         DsZeQZlJn1kMn9j3mAYc2TzVZsiO9f4Q83+DJbqIPYSum7cPR0GF3jca01MfoATS2R
         IoYRegacHRV7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F3BE6CE0A1C; Wed, 26 Jul 2023 14:12:35 -0700 (PDT)
Date:   Wed, 26 Jul 2023 14:12:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 5/5] Revert "checkpatch: Error out if deprecated RCU API
 used"
Message-ID: <a28a2b4d-18f3-418a-ab9d-46d42616a118@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725232913.2981357-6-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 25, 2023 at 11:29:10PM +0000, Joel Fernandes (Google) wrote:
> The check for single-argument kfree_rcu() is no longer needed as all
> users have been converted.
> 
> This reverts commit 1eacac3255495be7502d406e2ba5444fb5c3607c.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good eyes, thank you!

I applied this with an updated commit log as shown below.  Please let
me know if I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 1f5f0053f7662385d9ead46d4c0d2d4fe9aaa73a
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Tue Jul 25 23:29:10 2023 +0000

    Revert "checkpatch: Error out if deprecated RCU API used"
    
    The definition for single-argument kfree_rcu() has been removed,
    so that any further attempt to use it will result in a build error.
    Because of this build error, there is no longer any need for a special
    check in checkpatch.pl.
    
    Therefore, revert commit 1eacac3255495be7502d406e2ba5444fb5c3607c.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9841148cde2..528f619520eb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6422,15 +6422,6 @@ sub process {
 			}
 		}
 
-# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
-		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
-			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
-				ERROR("DEPRECATED_API",
-				      "Single-argument k[v]free_rcu() API is deprecated, please pass rcu_head object or call k[v]free_rcu_mightsleep()." . $herecurr);
-			}
-		}
-
-
 # check for unnecessary "Out of Memory" messages
 		if ($line =~ /^\+.*\b$logFunctions\s*\(/ &&
 		    $prevline =~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*==\s*)?($Lval)(\s*==\s*NULL\s*)?\s*\)/ &&
