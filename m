Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE933156237;
	Thu, 16 Jan 2025 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057753; cv=none; b=k/kUR9mOwLVQQbkCRerwDxuiW+crIyLFfMPSGiC3qISi4a/jy4n4uDxrwOZGmTHPnX+5flor9+xFC85fDfvf88g/AjUi9qnWW7KPrCrr0O9z0T2Nypx3dE58PDXHLZ/65OYyau9bUhsSoAEklOYJTcxusZ0KHu7VxhImJ0M6IWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057753; c=relaxed/simple;
	bh=0FDjVMxgOiLXJSywxejAjuj/kC4VmxOJ4HsD84+Rtvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qNPjpjLq6NOA9vIipvy0840AwUzY6rtb/yGbnbEP/06KPoDjWoBWLZqAT7O1FvlY0nrzrgEHGGKqfL0CoOU3x6dmUDeAYSaCxh8XvhsMCeDZkGVTbZvbZqEHC8VmcNDiN03+ILzww46ZvLfiR+J/l0Jx4OzMOqxS/RXH735/oqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWnPxjnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWnPxjnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E75AC4CED6;
	Thu, 16 Jan 2025 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057753;
	bh=0FDjVMxgOiLXJSywxejAjuj/kC4VmxOJ4HsD84+Rtvg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=UWnPxjnvDUXfT/iQqmKKNfREXpQbFL6BR3Eg2Yu+8Pk1sRCtQOFV0zoxLre8LvVi8
	 UVmeXQULErB0W7N7j0mfUUUHgZsTO932XZxUlpwaDg3EIFbdPFlp5hurYS/jSrvzck
	 mcw3JlUQkvgCOrT05i6hp3Bc+H7D+mOO9minyEdMEuZIUiwQ3Kza2N2gAmZC6QPW+a
	 tuPXPN7ambdwhAa6r4KnWAncVtpBSQcdtaMys9S/oC0KZXZ/ny9UW3qWhL+K0pxAfV
	 /8kt48k+jYWTYW6VmgJMVLObpQiPZpFE9HGE92IcDfl31ESOtXhkeMCph91Gl27jtg
	 +3giJBVARTA2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D49BBCE0EDF; Thu, 16 Jan 2025 12:02:32 -0800 (PST)
Date: Thu, 16 Jan 2025 12:02:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Documentation upates
Message-ID: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains RCU documentation updates:

1.	Add broken-timing possibility to stallwarn.rst.

2.	Improve discussion of this_cpu_ptr(), add raw_cpu_ptr().
	(Not actually an RCU patch, but here it is anyway.)

3.	Document self-propagating callbacks.

4.	Point call_srcu() to call_rcu() for detailed memory ordering.

5.	Add CONFIG_RCU_LAZY delays to call_rcu() kernel-doc header.

6.	Clarify RCU_LAZY and RCU_LAZY_DEFAULT_OFF help text.

7.	Remove references to old grace-period-wait primitives.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/rcubarrier.rst        |    5 +----
 b/Documentation/RCU/stallwarn.rst         |    7 +++++++
 b/Documentation/core-api/this_cpu_ops.rst |   22 ++++++++++++++++------
 b/include/linux/rcupdate.h                |   17 +++++++----------
 b/kernel/rcu/Kconfig                      |   20 +++++++++++++-------
 b/kernel/rcu/srcutree.c                   |    8 ++++++--
 b/kernel/rcu/tree.c                       |    8 +++++++-
 kernel/rcu/tree.c                         |    7 +++++++
 8 files changed, 64 insertions(+), 30 deletions(-)
