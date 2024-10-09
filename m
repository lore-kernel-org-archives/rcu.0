Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C529192D6A;
	Wed,  9 Oct 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496969; cv=none; b=KqKV7z9iRezj2YjeWF57okhREP0xrQd7KySh0E7cV7jWHqFOo/ONrWDrIzIkPzL50B9sLTbvRIkJkdxsrlzVqrbCCcBmBBAlqp/FfPbIGRBVuTbjavx5yvddsGo0AxDMOwO6nETdCK/RAwGDlsp8MSGnhXA5nfy0WuQsqUBDObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496969; c=relaxed/simple;
	bh=6bpf8Ex9s1V96vm2Q27AA51LFfXFXo5q7B4swtNvgTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hko3TdduOsGm2hqT4p35TlDKLWIi+ob5XExPlPsZ9QDXHkk95LEr3VtmqQ94HFKvrTNc4C8BkC0DDojQY0Njh3TstVsoVN73o/oSoEMsXvEyPG5OIqI+TEBLwJPK4t/ZkXlQrITmU7qmGEb0v3HhrFd0q76MW2EAIhLHi8qmAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7wb2KD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7wb2KD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC878C4CEC3;
	Wed,  9 Oct 2024 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496968;
	bh=6bpf8Ex9s1V96vm2Q27AA51LFfXFXo5q7B4swtNvgTU=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=B7wb2KD41fSzPRMC80G2lWP89ZTXUfb/A6keAUU0JbqOqEC0ryIaFxKKeOSQbiZQl
	 f60GKke2pnknnKK5ZTyEROTECYwUuUQTgWV3ZKwhD0aE6IXxonsO2u+OKmb8tRW6hG
	 Q45cfHTKJyKeJGuC9SCemI+Rp9Z9J+ymmIgsYFd2lXcfCKk80UfeHXlcUN0gJ08p0u
	 TNXGDJIwjPkuy/jkhpE4Rsk/2ff47nxl5PnBi23IBOTm/K0WxW3vv4AsIIs9SKeAQc
	 5SxQVpPs0JTsw1Uw01r2/wMHzN3hoEqOn9O0ltRyHVg9VQi1ai5KjM2VqegQk0JreG
	 OsaV2C+xOKngw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 74299CE08E5; Wed,  9 Oct 2024 11:02:48 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:02:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/5] Torture-test changes for v6.13
Message-ID: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
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

This series contains torture-test changes for v6.13:

1.	Add test for sched_clock().

2.	Add --no-affinity parameter to kvm.sh.

3.	Correct affinity check.

4.	Add guest_os_delay module parameter.

5.	Avoid printing cpu=-1 for no-fault RCU boost failure.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                                        |    9 +-
 b/kernel/rcu/refscale.c                                          |   38 ++++++++
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh |   43 +++++-----
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                  |    6 +
 kernel/rcu/refscale.c                                            |   19 ++++
 5 files changed, 90 insertions(+), 25 deletions(-)
