Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3F29B78F;
	Thu, 16 Jul 2026 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161695; cv=none; b=G8W3PdZACL13zhCSwtbfXJ8/J9vrmgx8TSIkKY4pyYJyxtZZcdeGywryhoKN+m8rzp7zG9uZ7mnQDK0DafexjnOI5MPZdFjH1emkQt6z+NPmSEgBj7EGJCePJdNkCf0xJvgJi2ONH2NJzC+MXFDxNEjOSgqKjn3tXY8NCS5F9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161695; c=relaxed/simple;
	bh=G2In8+xKQwIEHz+nOQdy53Exzh6JYTKw0KSVKdubik8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MsYx1Tqf73v17nnqJXKa+09J+jTg5hYcWqPL6a3K4v1M1LREdynJzMj4I1bor7gshRXrxZeDxYfB2qS0ky6TzHiorJMZOvLHHpEa2Ng0QmDlHaM0utg3UN9rewQVDW2b9aPTqAGhzQA+XjjnESowab5Nwhbe5O1ppiRMwsvL2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEEdzTN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEEdzTN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6FE1F00A3A;
	Thu, 16 Jul 2026 00:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161693;
	bh=170iPSVM1HPbkvavMj3ykBLg7JRBn1BqWNWEd9DJHLo=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=KEEdzTN67AtUFG/Onu76kD3eLVlombN5vjV8o9N6SkJdpv1Ar7lWzqvu1BYmXHYsG
	 0MN34dd5bRiqMmYk2XUN/5cZGDoWLGs3wQ9bim+Smf/c6XI5KD7TDN2azruQlMIlpY
	 JExto0/t7GlRsWNhBMv3v/fEZVLI1mPTtY0QogOnfe5VSmEGOxJxJuiFW0zmFNGNB2
	 7+Le6XVMYvtiDJ0AAyevQC0fI0Evo3Cfco32CaDZusH9SezqHfPWlAQhEHbQHaGIdW
	 F3Jf3fq0aXDfE1O10l9hMGOTGEcRBWmsdh/2nPYijxEK14PqTwC2iFZSfL9LvJORun
	 Rz64sdRzahyaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5816DCE0569; Wed, 15 Jul 2026 17:28:13 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:28:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/6] SRCU updates for v7.3
Message-ID: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello!

This series contains SRCU updates for v7.3, most notably Rust bindings.

1.	make init_srcu_struct() consistently wrap __init_srcu_struct(),
	courtesy of Onur Özkan.

2.	helpers: add SRCU helpers, courtesy of Onur Özkan.

3.	expose srcu_readers_active(), courtesy of Onur Özkan.

4.	sync: add SRCU abstraction, courtesy of Onur Özkan.

5.	MAINTAINERS: add Rust SRCU files to SRCU entry, courtesy of
	Onur Özkan.

6.	Queue sdp->work when the delay timer is successfully deleted,
	courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/MAINTAINERS              |    3 
 b/include/linux/srcu.h     |   29 +++++--
 b/include/linux/srcutiny.h |   13 +++
 b/include/linux/srcutree.h |   24 ++++++
 b/kernel/rcu/srcutiny.c    |   12 +--
 b/kernel/rcu/srcutree.c    |   11 +-
 b/rust/helpers/helpers.c   |    1 
 b/rust/helpers/srcu.c      |   30 +++++++
 b/rust/kernel/sync.rs      |    2 
 b/rust/kernel/sync/srcu.rs |  171 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/srcutiny.c      |    2 
 kernel/rcu/srcutree.c      |   31 +-------
 rust/helpers/srcu.c        |    5 +
 13 files changed, 287 insertions(+), 47 deletions(-)
