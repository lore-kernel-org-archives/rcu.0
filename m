Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AE48642C
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162689; cv=none; b=TuxEToNBnwa8ZGT3lga/2hKGdYoWGHdZRzYrzNeUnjlV2198N4OWVwKo4/FKHTyYQNkMckZgD2DWNfggEKj06I35V7w9luZ0xMd3CVEs/hEX+Rvs5fKRmONcPzYs3cE5Bp2uPaZIGdcDXXvK/3xDJhVRvH4LZZpKvtYR0j/2Qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162689; c=relaxed/simple;
	bh=ClD5QORMe+T7KlqLkjuBAZ9dv9PM3PDkhKBRwgMoWLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mhd+JMRyUF7Q8EYSGBZJ+giUhFVwcTzuA2QnajcieX5gDVCHHeUd/ZjKmTGvKh4s/0qhz5qPOI5JiJAn/F/IhoptaRoSMCP6wp1hYhsWkzTzFfaxnSind+hSDZD4O+DgCkbzPHt9aADJCC4BFw58oPIpK+OCtIa+X2T1GjJ9fPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx5Fls+l; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx5Fls+l"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so1586665e9.0
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789162684; x=1789767484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=24Mzmp7Zxy4s3Cg5qdBkPUcd813XnEgqkzISXqGAntk=;
        b=Fx5Fls+llyhAQ/U7oMHF29YA5eb1u9hM711yRbW2yBCTNFicl/+Bvn57AZ2nudmr3s
         t2IPYWaEMQ+GCS3blUWNDgkZUGsy9GnM/C40+4yD3crdUcl+UDVH4QzObTj90yzeUrIy
         XwYnVN98V3kcfkM/Y4XjH0uG3H6n/vO8Splw2DD2QjJ+ATJtvhjk4UgZqgrBDXs03cnX
         gCsvNZ16gYFUqfnNRqXTpv3CIPLrApIQ8WN8WyOjbg3tjgH0C8+nDM17DQ8yL6Hp2jEn
         rwGkvHijJ+N4ioXyolcjpe/yuf1wsqgysmAFPd25yXDMMB0U1wh4KU344kv6uzUfpYMT
         K6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162684; x=1789767484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=24Mzmp7Zxy4s3Cg5qdBkPUcd813XnEgqkzISXqGAntk=;
        b=O6Lpeji5d265hTje5VCM5P/yS9UeI1D43v4ZHCgagPTRbpaPtjJjONkWoCNEGZ1gMs
         zBNXk+MvH9dWrheUiCSFavtjoC4H3T8J0NhPcY/GX2LMazzJv7/dmq8u5iv2PIhxCgVo
         qfI43gADoAfzOgpLU18nhgAdPQUDwrwL3ij2oobe2UVYIbpG7I/lRxhZniD37n8pOZ3q
         zRTKywGYeQPP8KkbnJF9kifX0C2Xg2PAvBmVsl6vv6jBLQIqMMubkNlNcfMMARN90eLx
         BwzoGyEUIzCxalwCxnp+hD1faMDbP4viy+MzH7NyufpT2R2DHR8fIhGRsfYxk4PMozws
         MdAw==
X-Forwarded-Encrypted: i=1; AKwUvBwT3nnew06hVsSPvq0n2SGmiI4nmfAzGWbqMr0GWKua2zf957+LjVflubehXnwRkARaoG4=@vger.kernel.org
X-Gm-Message-State: AFuF++mYuPpsjsJx7+11RAcloMbL/htGNffulRvW58/jj/vUXcueA2b9
	0rOEiQViAjL9X+jwX3F6sZMruUc9m5UDS+YBTViee92hVP8yb1AluiGj
X-Gm-Gg: AYBFou0VpMWPPAE/EuWk+WwpWyx0+PQhOSOTGNpi22ChMO1dNdTkRnXCeVCWGrAu9wx
	b8m4IpEJY8SOJ9OMJR1TUOxUBoPfchHO2xidBGyNcuf5SZUKQkEJ6bJR9D53k1fhydnZ8MiY/An
	GmGUHyTFqoGYPrcZAa2a0inK911oCq3WNC1jtZQMF1Kb95R3mjWyFtY1vy8wzQT34Q0RKwj2A7C
	5b/h6SpTaKhSH5eva+yOdjVCy34xALA+h/M3LAZvMKWiUr+AHXOKncfmoq9qHqIKRcXM5kx4IQo
	s9o9BHeBM8XvFDdZqiSNZwO+hpyRBmivd8WRf3CWZUdyGhmOvjcL7+fwnTl+X3Utie90k0ymJuu
	czmAPt3KbZzic1D4007kzmqAxf3vs+g27VHvvzRF+HM+sSYmOQiU48DsW1AxhKS8NGm1mDFOJfW
	7giISAcbVSLMSqeFvtDVV38VVT7/s88iQ+Cz+r6qxS5AA/lUm8Bx7ros1nZdVzm4UqiwqxNUHWd
	7EbaThfr/yYiC+3EInE9+mxMiYBisxF4Zb1hleKek3+4sHFBch7LB58gpAddM/te0lRmHNWx14M
	+1UPPJkdzwTsDU65w+sGhmww/yxWp/MY4uMi1N54cZEAKhYA2tG4
X-Received: by 2002:a05:600c:3b23:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49e619c2722mr120896775e9.15.1789162684154;
        Fri, 11 Sep 2026 14:38:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm151033685e9.14.2026.09.11.14.38.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 14:38:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcuref: Fix the rcuread_is_dead reference in rcuref_read() kernel-doc
Date: Fri, 11 Sep 2026 23:36:43 +0200
Message-Id: <20260911213643.3781-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment of rcuref_read() refers to rcuread_is_dead, which
does not exist. The name is rcuref_is_dead. Say rcuref_is_dead.

Fixes: 3efa66ce6ee1 ("rcuref: Provide rcuref_is_dead()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/rcuref.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 2fb2af6d982497d346c821863aa366c9082526bc..01fee161b67c3ec9fbda6c3ffceab127a2721da7 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -34,7 +34,7 @@ static inline void rcuref_init(rcuref_t *ref, unsigned int cnt)
  * indicate that it is safe to schedule the object, protected by this reference
  * counter, for deconstruction.
  * If you want to know if the reference counter has been marked DEAD (as
- * signaled by rcuref_put()) please use rcuread_is_dead().
+ * signaled by rcuref_put()) please use rcuref_is_dead().
  */
 static inline unsigned int rcuref_read(rcuref_t *ref)
 {
