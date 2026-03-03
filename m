Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E1375F91;
	Tue,  3 Mar 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582346; cv=none; b=jW2BxeD6GaZGFJwbYC1sLfKa60943JIv01coq7AU0xC35H63nrTkhKtXWSN7wKTe86KPaxCeLEMl4sV1fkuqmIED2IPKk5rNkyOftvFUYHjlt3WeP/Nv7j9TRlasCQf+nmQEDszmedrkYWnQdmk1cxbEF+lpW52qSTfkEoLnxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582346; c=relaxed/simple;
	bh=vKjLzYNjaY051GqOnWGytDflMESzjuWZkHPzFfNrKiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L66UoE7DNLy0iNF1FuUUNbxUcGJPMfgfhA4ryBYuvbx2eF7NN/v78iz3BrqgTiQWeoX2pRyOz6FeLPYMlrVEe4MI1jTYe2wF0MASyTkZaIvw8iRAo1G2lcleBGupkKIujMApr6BeKuZUqQ2gLC68v/42cNezlDUvnm4ER5EQAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXDefOl8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXDefOl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13842C2BCB0;
	Tue,  3 Mar 2026 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582346;
	bh=vKjLzYNjaY051GqOnWGytDflMESzjuWZkHPzFfNrKiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXDefOl8zsRPoN7u1KTXUbIjw6NpcffDNM8oMpGUdEHZ1aUS91uE0tb7PbViBm4ks
	 +kkGCCursQ87165P6IdN7ZCOwLNZ4WCHPB73liUO/PRIOIIcEXhrWKF34MHLbyHvd7
	 7L7FY6j/XWT1bhryTgjRW0V/N7wiEiUCwM57AJgy7klZfkV5Ubst6DX77/8rQqbA1j
	 sn42P8uESSF6FR44emzTC9Mvank7KR8dhZuG/V9gb68MdOqe06qHho5G8Rz+aXOyFt
	 gpNoPcNqdojQo3ln7MqMmr4vToE6QgxeiZ1n/8dzrgq7wwupzpcSCaVbgKe6CpFc4H
	 TmslSeOcapDdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A7EFCCE0EDC; Tue,  3 Mar 2026 15:59:05 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/4] scftorture: Update due to x86 not supporting none/voluntary preemption
Date: Tue,  3 Mar 2026 15:59:03 -0800
Message-Id: <20260303235903.1967409-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of v7.0-rc1, architectures that support preemption, including x86 and
arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
Attempting to build kernels with these two Kconfig options results in
.config errors.  This commit therefore switches such scftorture scenarios
to CONFIG_PREEMPT_LAZY.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
index 6133f54ce2a7d..f9621e2770a41 100644
--- a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
@@ -1,5 +1,6 @@
 CONFIG_SMP=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
-- 
2.40.1

