Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E12773D9;
	Mon, 29 Dec 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035636; cv=none; b=Lvwoxaj7KzUTqnoOo4gF+byc5uQp+3qLhZI6BOLsv6i3dHdGTJpae5gyUrxya3aRlslW3LonY3yTnEy9/kSeeb4sEEqRkQPciZiWK8Iuq50eYYHEhMsxmhHEn7iStZGS5pzJmjTDi3c981LqK53nI8+rKy0EtBrsuB2ym0o7AkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035636; c=relaxed/simple;
	bh=sTD6D/Gc26mDyr+dleIkyAZSRJ9f6hJm15/X7Gqm2kg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iKdYlgCduF3DN/hSesgHLZbamZA1DSpAL0JtwowyG3dmDSBx3uGNHd6iYyF+XPgE/4lPckXNbTG9dnp8DkQPL7KJK4CmIt0bs+wnu7RK01dcAzYXcDpf/qbCGyVH6r5kYCXkAVtbbQBhAnN01uN6KGu5g2qj88Z5Qoc4EWdOMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeEZEKZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeEZEKZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C830FC4CEF7;
	Mon, 29 Dec 2025 19:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035635;
	bh=sTD6D/Gc26mDyr+dleIkyAZSRJ9f6hJm15/X7Gqm2kg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=BeEZEKZBEbwP8r5KH7H2LMrh2UMnkmJ4p0rUs9+zurTPb7Hfjf3vcovJlw3ajy054
	 SrloeSFJb1TX7WM5KZ5Wtay8xQiR8CrdxNynbZ9ycC7tNES4W3VrtvVMZaqgCM4RF8
	 CcgcHia3vGXwAYdipoK1pFZb0942sGQle5d806o5eL2lmRxdWsISgmNGX7eTl95anj
	 LdmWtsB7uqpRoAFifjXOZAubyKYhZ7gmx88C5YAzEXxn3D3WGSaXQGeAuQhmWDj6ze
	 eenM2BovNbjlUgGdvirGxZlg1r+K9T8RhGbd4JMJqN/wdLNjlRMigKL1PA4X3KFdV3
	 b/jTwgBVcT6LQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5E545CE0C97; Mon, 29 Dec 2025 11:13:55 -0800 (PST)
Date: Mon, 29 Dec 2025 11:13:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/6] Torture-test updates for post-v4.19
Message-ID: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
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

These patches update the torture testing, most notably improving the
performance of kvm-series.sh by a small but useful integer factor.

1.	Add context checks to rcu_torture_timer().

2.	Parallelize kvm-series.sh guest-OS execution.

3.	Make kvm-series.sh give build numbers and totals.

4.	Make kvm-series.sh give run numbers and totals.

5.	Make config2csv.sh properly handle comments in .boot files.

6.	Include commit discription in testid.txt.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                              |    3 
 b/tools/testing/selftests/rcutorture/bin/config2csv.sh |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-series.sh |  176 ++++++++++++++---
 b/tools/testing/selftests/rcutorture/bin/mktestid.sh   |    2 
 tools/testing/selftests/rcutorture/bin/kvm-series.sh   |   12 -
 5 files changed, 169 insertions(+), 26 deletions(-)
