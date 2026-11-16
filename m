Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849957;
	b=pigUovF2B0GcgAfI0nGslO63NgYiRoSzEcgVxdr7pbVvDnq9NIzi1R/O8Oo7I2zF/sjK
	 7I89hGoAI5nFiubTKSL8yDse80UE8KR+4VID9/AWyxZdW5yPx2uDhClpSXcdvhfpH6lLR
	 ZkRxXtu5ivmjp2316abRYMcObFs3ghKvM5RHCeINaYfAMa7E8itbKehcwYV/aKZ64VtgL
	 u96yz8kj3l35rgeItwDLWpktfxhVCJTmhzhVgs4okRxTSyy5WP5uNm7d9MOKd752+OOqC
	 p0hGP+KH6+IGAOvz2a/HIWXB03O7M4a3gqeMrX9ty1QCTQpAG4vPAT4PTC/5/M5Nldw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849957;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=9VRvDzfssMKyjDxEy+5j1OIP5iGW/JNuoBFGNQuTQmQ=;
	b=2/XMWV5GIeOkrdf2ISsoRq4MsAqUF0NHdmUcCnNA8Jghs0BW665kKr8oLPPW+od1ILVe
	 IrLwSL6SyaI6fBkzHMyMeZmaN4V9o7zTSpZMFXCsDbRmZBnSI829uupZ0bO3SbYGvCTim
	 jJR1rRKI8/QGbsBT/nsJwMmd28GzWjsGdVDT0JgJwwav7yuQrqvzmIBOPBuifJ0h+HCaX
	 k0pzGzS4rJjw4kZg6Rx5BW3xC9OtoRuG+pAnGwYd6fnCOtsWwd4TdMWLz0G3x5EgAX4OF
	 nzCvVWQCrkeQF6Z7MAaF7POYafrvvVPCeUUxGtik8xLH4GPEfeBABf1dt3EHQOLuRXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlDIEf9G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170BF606A31C;
	Mon, 16 Nov 2026 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlDIEf9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6FB1F000C4;
	Mon, 16 Nov 2026 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849956;
	bh=9VRvDzfssMKyjDxEy+5j1OIP5iGW/JNuoBFGNQuTQmQ=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=ZlDIEf9GaVSE+4nekwCztyvHnbaLzFP22FD//jdwIEi1Bl7nQ1En/yiVTT8/0QAKi
	 DfZBjmb27SVKWxUNdHvfPtJr/5lvS+5dwq8DgaoL0H0ynMNtI/fD3mB93LYVVaspmI
	 ZjsYkpZVUhCLiLvArNeNUivW8SgpMyBIYuAkLGnzLl+pDlv8RxAP9D8c+19O1WRTqJ
	 nqjJ46vjoDvc1T487Z/B8izJ75HjhJ3mK4w3v2urVynwnuUcLLdIEblSyvkjBTaYbP
	 eUWEXdtr5PR93jz5iiZxSkNthZodObLIaKAyBeBCTZxxk0uhK3XPFGieOpL0n6ick/
	 Q9X6B7uvzK/6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 694ADCE097D; Mon, 16 Nov 2026 09:25:56 -0800 (PST)
Date: Mon, 16 Nov 2026 09:25:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	Joel Fernandes <jfern@kernel.org>
Subject: [PATCH 0/6] Additional miscellaneous RCU updates for v7.5
Message-ID: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
Reply-To: paulmck@kernel.org
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series provides additional miscellaneous updates for v7.5:

1.	MAINTAINERS: Add Puranjay Mohan and RCU reviewer.

2.	Make torture.sh test NMIs for atomic SRCU on x86.

3.	Avoid duplicate identify_qemu_vcpus calls in torture.sh.

4.	Make torture.sh test NMIs for RCU on x86.

5.	Make kvm.sh ignore empty-string arguments.

6.	Use ${:+} to save a few lines in torture.sh's torture_one().

						Thanx, Paul

------------------------------------------------------------------------

 b/MAINTAINERS                                       |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh     |    3 ++
 b/tools/testing/selftests/rcutorture/bin/torture.sh |   11 ++++++---
 tools/testing/selftests/rcutorture/bin/torture.sh   |   23 +++++++++-----------
 4 files changed, 22 insertions(+), 16 deletions(-)
