Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785812;
	b=CnUFumCimbbMxvt7I9Vdsq3/glFvYTVueYMRBWXJJckJz+Scov91NIdO3of5QSgRDyrV
	 WnCOSk0dRDAjq28DXDCL0DX3BHcWcIrgPekDv/yiCw1yHXKRo+x+2qcZ11bHHMF+ccesi
	 LAZ/pvgcIdOoF0VMDcn1H/BRaM+pMdVdQC6LclrqoV2O3dB4ZHIUXfNdAX2z5bydRo8Mk
	 F5uDJI8kMHAYvwrc5D+ehpfpKk3gDZFUVtWnf/jsT/9zTIfkrVhOsAyFdaAfFtFqPEjD+
	 bptfOCuoanz36pG4imAA6fgBzlHhNFH5nDQbmDpFfJQOFgg9TDgvXCjRrPQSGQYTUxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785812;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HTW57oooC7Aetua3U024GoiLpoGEfEdZnN9P2wo8dD4=;
	b=qxY8wnCbdsYI+Q2BxErhhN3tiE9iLz+O3cy+cHtYCSX4E++OOwPj8pdUlHVdccvQ/T1X
	 H0mSLDa7jhyR9twemRW7aF/pfvW9yzzMmHiWxMItMSLxOwN9pTUy2GNxXKSNrKVQeIrMe
	 TeFVB+YVmP9RhsNK7T0lgb01LzainUrnz2PSNp+YfWtcaIZNYjmJ7bU0YOt+V3hYXn/Q2
	 HyJ8PYKxX/oOH2ZnIkP876UtvglNJwpish3+Ga3D+1Mjoaef7crIzJ7P9GZJJVLSDOGKL
	 MZHRRUObt99YlMsflznZior2q9cGDkjWO8I3bPFob1YWUTdIaytDEPPDdcWVJugcktg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/tmfv1e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CFC45606A332;
	Sun, 15 Nov 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/tmfv1e
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4F6791F000D0;
	Sun, 15 Nov 2026 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785812;
	bh=HTW57oooC7Aetua3U024GoiLpoGEfEdZnN9P2wo8dD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F/tmfv1eUYx150AKaTv49c7FI1FBCAQty//JMKSY1JG8hVMhRdKeoxNuuoAP6kVbn
	 geS8+gc4nQWUbRoRds82dslIpWB9OpmXmkcg5zS4gzYhyV/OLezl8gioLasdLnZ8sX
	 r8k/CtqDfsCgPuJw3DDTB+XB6kwYiLbAuFFSmQcEx1snn8hnwXzZPpKLgaK11wBjz2
	 XX4YO1lbmUwiNx7m7WHyCqBjTo1g+A5gmGXF7k7KD3MKsJf+E6ZoeQlAp97L1PAcOi
	 /58unaeNBpG+DvmT0/qUXD0EJp1aQchrmVhvlCkxE53SReM+vOcjXsqZ3N7CKmI/II
	 rqs9+1giBJj+Q==
Date: Sun, 15 Nov 2026 18:36:51 -0500
From: Joel Fernandes <jfern@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH for-v7.5 13/14] rcutorture: Disable RCU priority boost
 testing on non-TREE03 scenarios
Message-ID: <20261115233651.GB3906606@joelbox>
References: <20261113005747.2977123-14-jfern@kernel.org>
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
In-Reply-To: <20261113005747.2977123-14-jfern@kernel.org>

Hi Paul,

Can I fold in the below diff?  Sashiko found this issue in [1]: 12/14 removes
CONFIG_RCU_BOOST=n from NOCB01 and NOCB02, so boosting is now on there too and
rcu_torture_boost() would start, but this patch adds rcutorture.test_boost=0
only for TREE01, TREE02, TREE08 and TREE09.  The diff sets it for the two NOCB
scenarios as well.

[1] https://lore.kernel.org/all/sashiko-outbox-213970@kernel.org/

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
index 5130bc84c435..fe37cfc8eadb 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
@@ -1,2 +1,3 @@
 rcupdate.rcu_self_test=1
 rcu_nocbs=all
+rcutorture.test_boost=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
index c212ae299b0b..3ea4f5c2a5ef 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
@@ -1,3 +1,4 @@
 rcupdate.rcu_self_test=1
 rcu_nocbs=all
 rcu_nocb_poll
+rcutorture.test_boost=0

Thanks,
Joel

