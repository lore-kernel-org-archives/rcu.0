Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F24EB64DA
	for <rcu@archiver.kernel.org>; Thu, 22 Jun 2023 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjFVVWY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjFVVWX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Jun 2023 17:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9B1FE8
        for <rcu@vger.kernel.org>; Thu, 22 Jun 2023 14:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D1AB6189B
        for <rcu@vger.kernel.org>; Thu, 22 Jun 2023 21:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E6EC433C0
        for <rcu@vger.kernel.org>; Thu, 22 Jun 2023 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687468939;
        bh=suECgDuka7U62vB6vRYJ4ByQ+Oo6/VQCSGpCBzEogH0=;
        h=Date:From:To:Subject:Reply-To:From;
        b=RVWaWbiNyHTBrBpv8bHyGEjf/O8eaYlDpjTFRgHQcVmFtaW4DAYDbQ5+yQBDKwKse
         7PuDq3Uwymcle5cuWg0UkKlQ1y9jcaEObiis6Vr9KRuIVTRC1W/A2bXYFsvRFVGxsM
         9YncBd5w81VNFJQy0tJQ3UDrum9lKpTbeb5fkVYlFVN7mAXPjOE5x8eo11jw94r9yL
         b5O3ozINLMHfuVCgGs1cuNknl30GmwDolsJ1ISJZ0+rZmTijAndn7Z4ewb9HHHL+aS
         IkSjGSJ83s3wV3v6yCfaJNKOAA9V2reIdZ8jyCIlB34dWFYRIrKmkSxqMn1/Ti/aTJ
         S3STSPCi2PpUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1FA70CE39F6; Thu, 22 Jun 2023 14:22:19 -0700 (PDT)
Date:   Thu, 22 Jun 2023 14:22:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Subject: Preview of RCU pull request tag for upcoming merge window
Message-ID: <2472cef0-19c1-4eec-b8b0-cd62a1466c05@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

Sneak preview of the tag for the upcoming merge window.

Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

tag rcu.2023.06.22a
Tagger: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Jun 22 14:01:35 2023 -0700

RCU pull request for v6.5

This pull contains the following branches:

doc.2023.05.10a: Documentation updates

fixes.2023.05.11a: Miscellaneous fixes, perhaps most notably:

o	Remove RCU_NONIDLE().  The new visibility of most of the idle
	loop to RCU has obsoleted this API.

o	Make the RCU_SOFTIRQ callback-invocation time limit also apply
	to the rcuc kthreads that invoke callbacks for CONFIG_PREEMPT_RT.

o	Add a jiffies-based callback-invocation time limit to handle
	long-running callbacks.  (The local_clock() function is only
	invoked once per 32 callbacks due to its high overhead.)

o	Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs,
	which fixes a bug that can occur on systems with non-contiguous
	CPU numbering.

kvfree.2023.05.10a: kvfree_rcu updates

o	Eliminate the single-argument variant of k[v]free_rcu() now
	that all uses have been converted to k[v]free_rcu_mightsleep().

o	Add WARN_ON_ONCE() checks for k[v]free_rcu*() freeing callbacks
	too soon.  Yes, this is closing the barn door after the horse
	has escaped, but Murphy says that there will be more horses.

nocb.2023.05.11a: Callback-offloading updates

o	Fix a number of bugs involving the shrinker and lazy callbacks.

rcu-tasks.2023.05.10a: Tasks RCU updates

torture.2023.05.15a: Torture-test updates

rcu-urgent.2023.06.06a: Urgent SRCU fix (already pulled)
-----BEGIN PGP SIGNATURE-----

iQJHBAABCgAxFiEEbK7UrM+RBIrCoViJnr8S83LZ+4wFAmSUuukTHHBhdWxtY2tA
a2VybmVsLm9yZwAKCRCevxLzctn7jLB5EACWArBYSbXh9kx6RP3LRkOd//fQWuqx
z/RmHjMx3a2uIQpsbeAj+jrgHYzSOi7Afdnx2s0gUIWGjpF4d+e31eco9xTQtWIs
A3/pXUlcTyaPXEZh5ro763UyBF/K003TAdo7EZAScTfDNp2knqGdEOyXTOXiAULX
GH922kIqg0chbYaWocLY3g5mXeEm+kGY8GrDAB7/B3jHgoyylXzmSULDP4GQV7hw
DkM0GOlc3TSzHonnNS6j1xboqY4HhWIDkBrD4Oh5P//ttMpb1b6gs1zEyjCQcNBe
a6fnNF+0dUwANIZKroPn/L1uTGsEUhmLFkVK+XIuAit97yWI6t+aRH6TzHHYmkpu
wVmLxv/FbJohP7ArWaI8l0gNl0vkli3ZgQXnRvSpCqIFR93AWVMeZsDTGOcLUdry
AZEnuGXHnc9UB0KGOIras0o/EQezKq57JUV2bBZjl/GIDc3qiaJKnBhHysPc1iuE
UfP052vCaoZxO3U/FrObQhjLZnstKBYHj8WolxMjIyNMlRIvDro6O1WG4+mjeLDP
xdrjKGstsJh80CYDei+vJBXsbszhxv8yV4hCQX9JcDl3RjEqOOxgKUnAaP2mm02O
MX33P3MZvSsHGoxkJpXDSlkQlbNqDBMIjZXbZLRF4o8fPhVmQU/4QlJN0iFOoXaQ
1qqGrerEzfn0Jw==
=3LCd
-----END PGP SIGNATURE-----

commit 2e31da752c6d0e892f2a9232e18da816d04ee691
Merge: e1bd2334f165 401b0de3ae4f 6b706e5603c4 fbde57d2d299 edff5e9a99e0 ce2544b2d05e de29a96accea
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jun 7 13:44:06 2023 -0700

    Merge branches 'doc.2023.05.10a', 'fixes.2023.05.11a', 'kvfree.2023.05.10a', 'nocb.2023.05.11a', 'rcu-tasks.2023.05.10a', 'torture.2023.05.15a' and 'rcu-urgent.2023.06.06a' into HEAD
    
    doc.2023.05.10a: Documentation updates
    fixes.2023.05.11a: Miscellaneous fixes
    kvfree.2023.05.10a: kvfree_rcu updates
    nocb.2023.05.11a: Callback-offloading updates
    rcu-tasks.2023.05.10a: Tasks RCU updates
    torture.2023.05.15a: Torture-test updates
    rcu-urgent.2023.06.06a: Urgent SRCU fix

