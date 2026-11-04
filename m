Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811367;
	b=0lKa5wWtCxp7VoDGcEwlIBaD3fKNoR0yk1bR9HNGNgazbpvEXUvamXBtaLOyqQt7nHqy
	 PGYVBsqd8UWWPKLn2jhYZZPUJSblbduvcRSeEWanGpzZdoJqEDzGQ239W/r8mbqPD8ek7
	 TfsNrTzHyVb7NbUnzOsH1pJ7X+M+dwlGGbsj6W5BTCerFBJ7epDcEtZqzmUUO1abDDpK4
	 wv13PUCTaEQ0R9F5CLwoKOLE7fTn6eeN2065LSqFZh4d55/mUjQX9Y61dgvWx4G/nfbvw
	 aOdHGCaOjWrD1blKaOWVhWaTQ167tsx+OxoPVLQ/QgAVl99PrkDVLJnjjH5btH8AxWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K4ahvqtjxwDZW1z/zIOwgCxGi6bAPzcPods0jeXHn0Q=;
	b=IIj/rASoG+9crUw4fJTzd1O4T96suxd3ngy2CdtsZUGtmnVS/o+HDeKsUTOJA9fiC+Ke
	 3QAdW+f5J0BWQK3//bqE9ue9v2vCJDch9mqscF6zUcbe+pKwg5oYmJboWPEqMSFwzt5MZ
	 bf+NrH7VWJAgeXcxGudjhTvpk0PK+EMHHuX6sWkKD+igE+SQ10pWRLF1vPArpWLZnh3FN
	 IUaWshXPjSaoZf1IDbgIqkGKR0fAOHgT5leLj3kQaAscTvlQWDnbNS32Er+dMsBG2F5BU
	 AfUX1i4ljmvRXi/HxhDMeiM3aBy2MWjk1owRWc3Vma7+nrags7PNLhsiNI8Cp4pCDXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGUkONor;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E64606A334
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E64606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGUkONor
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a18fc7a38so2023521eec.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811366; x=1794416166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4ahvqtjxwDZW1z/zIOwgCxGi6bAPzcPods0jeXHn0Q=;
        b=UGUkONorfwM+zbVj6eSQLZ/CtHpB5o6WUk5r6DRCTGw9BsZ3jYHEXXgAeUMXpdkKHw
         rOZh0cr3KpIP5HIpA47NNa2SvdgBzVZO9ouBTKR1uZ7I/v8x7qERHplfE42RZ9WkV9rA
         WhTMYE7yMWjkIdRnqeFALhk6GGbkABiCkQLU/LhORN/exgEintJBo2+52BvPekR5iiCg
         JaiaFNJVcOrSF5SWDQcIfnWQzeik44hR0n1dwFRYF1zMjcPvRGBJLcLTj5Qezw261wSm
         VRmyrgJiAM2eYvZ3x5IdrrkO1UP6/IpCBNjSbQFnbFoLKEC4WWZ2HEP12RSgYhlCsYXq
         akpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811366; x=1794416166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K4ahvqtjxwDZW1z/zIOwgCxGi6bAPzcPods0jeXHn0Q=;
        b=lMQQh61C//IErfmFYEI2mFtgJSHudtEP7mgTuTt8SPMT9rdiVZT08cGBzXB9rXKWj3
         qbYRWxb0LA3Kh/VGdcRi2Me3auJyPb1wd1N0i24LQxMNQqZDhIK7wyqVaKVu+EO2EalV
         35lma8pkg2qUcZVThhhfrHxTQjjdSbE9VHE1qWa/Eb2QJkGZLFN2H5m/ONzVWq11huQ8
         wni3O4gMRFaCTrggbRQ2PD9WZ5W36VvZLYKNLwAwkgUJSaTliXSXHrNpppKi0U4mq+hh
         ceSDeR3dVxajTOsqFeXHdIDvzoWTzzPxkpiDDMLNeu/q2SG0ylW74e2HVWRJOvEcKk3f
         SrgQ==
X-Forwarded-Encrypted: i=1; AKwUvByQ13RzmvQQpaC8durnRPDnLfYBgC5S71ytTnJbLI5oHlLgbv3G6LSNNo7OMuArMmBq004=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pIbXMj5/rEMXdot7fFOcZxGMBGTagzqvPjPIPk6qE/FfE6XlE
	pr/JMCLGnf/1U3vy8Z+v+QsJHLSCzcH+aGb5/EXBWNMrArMb0zR1YIZp
X-Gm-Gg: AYBFou3W9S2Wf4yyWYZ7MpUwUHNwmv3xRDUbErgZ9JQNs47o7isZH20TMWgyiKXdQXT
	z9CREJ5HN4AWkwhL9TJuKskOZtLCI3bqRnQhNvQtwoJNY6n/PE7xR+AFXrm488BXFOeHgsWgN/s
	baSlwhNjGtlSShSKGW2yZqZ26rDf0Fri5KKnfMh5AE2CAisYZPwSio003m6vc0nfpRzrm6e89iz
	uC+An6xZqqJ8/fvsx06/1XwgXcYloCLJggNCM6kJ6KQEpXmS7VZok4F1nyJo+GXS3+pILZS57Av
	ccw1ON8R0fqK6RzVkdJ/PbeWlDfr22Q8OJmqoedo14NYjU5A4wOPy5Eg5LQmz5loWE6ZX2xU4b8
	jt0DKsziN3gRV6tZb9gfTLkDTSxPbMAsEPXp36mzx2ZlHOgAuUeTyGMvN5CLhGEQGqZgnGyF0HD
	0pcX/CN8U4heRW7a6b+kx7i84TaXXF4t4Ey1hHpD5yjCsZzF/8StWtaCnpPJNmdeYaFdvs21S80
	b4BJdjyhoBucExECm+fOkVmMx8o7ojAGfB3JN1Bgjs4CXjiy2Kq84dWSuYloZg6ohdD+X6DtgCF
	s6TgOu4nWtYJEuZZAmLVlHJxhSFJC/YMQl5hwlM=
X-Received: by 2002:a05:693c:895c:10b0:369:f05d:6c5c with SMTP id 5a478bee46e88-36a4240f66emr26391236eec.28.1793811366010;
        Wed, 04 Nov 2026 08:56:06 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:05 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 05/28] Documentation/litmus-tests: Add hazptr wildcard-flip escape test
Date: Thu,  5 Nov 2026 00:54:23 +0800
Message-ID: <20261104165504.2430480-6-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a three-process litmus test for the in-flight wildcard window
of the single-pass scan: a straggling acquire which published the
old wildcard after the final walk cannot still load the
unpublished object.

Verified with herd7 (linux-kernel.cfg): Never 0 13.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 .../hazptr/hazptr-wildcard-flip-escape.litmus | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus

diff --git a/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus b/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
new file mode 100644
index 000000000000..de467bb82d20
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
@@ -0,0 +1,46 @@
+C hazptr-wildcard-flip-escape
+
+(*
+ * Result: Never
+ *
+ * Check that a straggling acquire which published the old
+ * wildcard after the final walk cannot still load the
+ * unpublished object.
+ *)
+
+{
+	int ptr = 3;
+	int hp = 0;
+	int wildcard = 1;
+	int enq = 0;
+}
+
+P0(int *ptr, int *enq)
+{
+	WRITE_ONCE(*ptr, 0);
+	smp_mb();
+	smp_store_release(enq, 1);
+}
+
+P1(int *enq, int *wildcard, int *hp)
+{
+	int r1;
+	int r2;
+
+	r1 = smp_load_acquire(enq);
+	WRITE_ONCE(*wildcard, 2);
+	r2 = READ_ONCE(*hp);
+}
+
+P2(int *wildcard, int *hp, int *ptr)
+{
+	int r0;
+	int r3;
+
+	r0 = READ_ONCE(*wildcard);
+	WRITE_ONCE(*hp, r0);
+	smp_mb();
+	r3 = READ_ONCE(*ptr);
+}
+
+exists (1:r1=1 /\ 1:r2=0 /\ 2:r3=3)
-- 
2.43.0

