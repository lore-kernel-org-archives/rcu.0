Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184E2FC876;
	Sat, 19 Sep 2026 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777973; cv=none; b=UdZgYcxKq1lclQjc962tnZztxFrl4h+B7DjacOoVMUEhtwRJl5uKuWJyJlrXx+iGnjbZoZqb7Io9oLQ5J7jkbl2ve6FVZNZhl2eEbyUvBiddMD4sZhuAw5LcwTL6Ho55zUNbca6wWVnun2q7ogYXAAB1GLK2E+7Wa5g46lSYT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777973; c=relaxed/simple;
	bh=Iftd8at/7oaXqRTVa45PAd0S1uHu1vNRznOzCZhazS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Unag6qG7nLU1vLIPGVOyMU8lC9nX5UKJyHMTPLmhxfqqRsKfSo4OFEg0J/NAKc+RGXLfI4bfemdj0kFsJPKH0cbc43EdAMb0WdPTh//skZUEKUTRN4qTU7IkHiHhNXNpES0IvEhLj7iuvPXD1fiuLLKL/WdQe9H7y8ZxRkw5K1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAzoFWlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAzoFWlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F12B1F000FF;
	Sat, 19 Sep 2026 00:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777971;
	bh=n3IHhrJ6drkRPdLAI7XId5OHkSWGwfO9t55O96NgUSc=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=lAzoFWlOCiFPVw0oKN1sC+DbCVJ0bK7B8nT0D027n2hnyNMlAcR6F0prFekiPdn62
	 RWyuRSdqxvUykEBHOJczuseLnYywEL3olHzT2fYUvOCtPMwCE4DYsMnMfsVv9Dyvvq
	 zueay33PGdLjW1MCfmT3PsKoCjIshdJvXZcfuO8a9vX9NmQ+kftaqIK9BW623uSBnF
	 MXr5hBKaxlfxatJMG8S5993hIsY729VZIHgwT4Dc/QD4/fdaI9tsWK9A9AGm3Rp5DG
	 WVROp+4d7ahzR+HR7Fp1IA/CsnpwM7At5lsNu03DWAK5SU5w0CbPbi4Mg6Y1JLdpjJ
	 n4a54VgdPpMNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33B91CE1775; Fri, 18 Sep 2026 17:32:51 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:32:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/7] Allow call_{s,}rcu() from NMI and BPF environments
Message-ID: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
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

This series enables call_rcu() and call_srcu() to be invoked in NMI
handlers and from BPF programs attached to these functions.  The
individual patches are as follows:

1.	Make call_rcu() safe to call from any context, courtesy of
	Puranjay Mohan.

2.	Make Tiny call_rcu() safe to call from any context, courtesy of
	Puranjay Mohan.

3.	Make call_srcu() safe to call from any context, courtesy of
	Puranjay Mohan.

4.	Make Tiny call_srcu() safe to call from any context, courtesy
	of Puranjay Mohan.

5.	Disable fragile readers during overload testing.

6.	Exercise ->call() from NMI context, courtesy of Puranjay Mohan.

7.	Add a call_srcu() re-entry reproducer, courtesy of Puranjay Mohan.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt      |    7 
 b/include/linux/srcutiny.h                             |   12 -
 b/include/linux/srcutree.h                             |    4 
 b/kernel/rcu/Kconfig                                   |    6 
 b/kernel/rcu/rcu.h                                     |   11 +
 b/kernel/rcu/rcutorture.c                              |    8 
 b/kernel/rcu/srcutiny.c                                |   93 ++++++++-
 b/kernel/rcu/srcutree.c                                |  170 ++++++++++++++++-
 b/kernel/rcu/tiny.c                                    |  127 ++++++++++--
 b/kernel/rcu/tree.c                                    |  131 ++++++++++++-
 b/kernel/rcu/tree.h                                    |    6 
 b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c |   93 +++++++++
 b/tools/testing/selftests/bpf/progs/rcu_reentry.c      |   51 +++++
 kernel/rcu/rcu.h                                       |    3 
 kernel/rcu/rcutorture.c                                |  150 ++++++++++++++-
 kernel/rcu/tree.c                                      |    2 
 16 files changed, 824 insertions(+), 50 deletions(-)
