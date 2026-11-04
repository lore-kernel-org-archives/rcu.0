Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811469;
	b=Yy48Z1QUl6CXlh6sZv90+0DsBfFvXca5YpPV44hrlf6UI3lon4mLvyuo15FYF5iq91G9
	 asRGkev6N+1KeRAVpyQyKFTwi48YzE6NRccpWFrwHnkQGYbiFp1QE6hEql1IMPyx/F2bq
	 speLtC91i699wEYGYAMi9W68LgMX4Ujf7HA3zlOtVXoYX8w3kQuaev7HEZVK09YzhcUgw
	 C3d1qEO+XK0J5+bLUZrGojnULv95B2omKf2plUgGZPjwvdMzKXBpDa87BQLbcfuaPyLEs
	 dZZ0MRX57ZCOolT0pwOHtS8jwWP8wl/o5mJeXN+OpOjp7dGfk8tUvH2wsd6fPR1R0NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HYFy8sOOELLyqP//oMKFGSpOITyv86S+D257oV2UNCY=;
	b=ImseNDBpwRsZFZysZCBvlo7OHUxYVRXqF1tWhzCBMN+cJWLDl1xW0zwKyW2Z+SMgdB2M
	 q9BYzM5s15RKbOLQs9YfLP3QnUu6xpW1xBhLS+eLwTN5H3hvgs/nLUcpgWnCrFj+pKoLU
	 qMgQjvMxb7YtrZ3TdKS2fmUAO4WszSpcU88OTFG4uvcDPI0lCqKU9mDYsqqdZhSJU2nX/
	 X1cQT3sKu3BLjSE9z/kLMavCQ3NV2KBK9EPAB3duW93vU2gz8idDSuMr8+20j4wB8qCX9
	 1+bodsv6L3WUGRroGBtg76KBiMno48JRAljBFhJ2hufPTZLC43TAQR57GpJajgcqj2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+yZfRyu;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80303606D814
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80303606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+yZfRyu
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35c76e9614aso1208585eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811468; x=1794416268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HYFy8sOOELLyqP//oMKFGSpOITyv86S+D257oV2UNCY=;
        b=H+yZfRyu1YpjAqnbnHiKh5xNTmCDYDOnNqBVbKlooMK+sxvVJEQXqGJdt2ppEr1oHx
         t435KiYlxJLi6R2A+7xJQKVHU0bpd0p4PwvDNarn62o3341CZREK7JiPVkwmMKTVkZNz
         BPuL/XdarsAwqfDbJv8Ra0M5t2G1eDT8Op+OY5grEIwd/imbjAuY5jPGa59Euw6GYLM9
         GX5rT/byFl19eCTBAowU9TiUfPVTY8CrphI0yYByVAzBDZsS9lwj0htyPQuwfm1cCYSJ
         jFIBEzQv/l9itvS6ELOYrAx7w4GDmZWPFyGVpIPncbIFaiHeSVl0GE9j3rCjCkbMz4Zs
         sfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811468; x=1794416268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HYFy8sOOELLyqP//oMKFGSpOITyv86S+D257oV2UNCY=;
        b=gVB2YZ5lnlrY3dYvIRAh2ooglFV/Xk0PUDyIQI59vd214L+eg/kAgpWEFI+EODg//7
         sKiAYnHbqjxvfa1f4ynQcdPllaeLu7iPJC5i4eCYwxIU++O3LDs+RRMgXXgvU99Mic/t
         uZCjcol7cHfwGmrQqfmD2+obRaAksbB2FuQlCPAfZnAGjtdS4FyMvLMFaZ4iY8rZzoGP
         qRdvIUIRQvuIp91ugI/Hg+84LR4DwHljkyuZqYrZ3uwSaNNaRD9aG9IQ/QwF6uARles+
         xyGzzY0RiU64Cb5SFqiz8QF4WAzYmAmioteYsWbWCRwyUV+psKiv0T0z0T/4Wp7obbsQ
         jmJA==
X-Forwarded-Encrypted: i=1; AKwUvByOlp/EnqLVuaL5b5RKnkHVhdazebOP5IiZPC6LDRvOuWtMdSlc7orLQyq8XOSc0zXCrok=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gGRA4nZHZtwfDF9JP2wxSuLb2cipaOgr18kM5J9GdBRjtAZDj
	rGKS4HCGTiy4ogl+FLlfoxovp4y72JrRyAAUtvp5o6fsO5lM9K+v64P+
X-Gm-Gg: AYBFou1Dga15oQLmbnn9gMqD5qUULDRoio82HXKPZNqqXbIqx2YDxZqZgYVCFJr2Jnu
	xo5Xh4JCLlpbj0QZ/bcfBvjvM2gv+yElYUiOSR8GCDJxX5aDuCFZ4si5deBCQ2ZMMNTXumRkH0J
	tMG3IV049/0VlaUGmM/QKWBAeh7FMd2+cDU2eYRLqUx3p6vZKUpuf76uAgGHnAf8gpSAeGvwIQ3
	nG+gTVxrflNI12EIttJ9zoyzw1O6Ged6fgaJ78r5GZxk6vFTxmWYgESMFGD11uSRi0c/4PG50oD
	vhpsOu3BiGtYfX3nOGxHmln7DvqhmlpiNPX/im954KPd4mfrZ9EMhVHtX7pW8uv9xMmOo1U7tm4
	n3O+36ZgESvPhFhTz++XCmEi/xT6KvpVt/cNxN7sGFLaJ91Hc6qRIzWc2zTlCd/EuscWCfwpkN7
	O4xOxGKK8fluSEg28d05qvAEWkyV1m+4g4NiGz59JdIPQmx0o39Yk4J8FOxfM4TRCY4bWu1HIJC
	T790Yxdi9+H8mCro9gANiqfIYKMZF78Bj1vDzlAcKClSpd8In9s/bN0fysLsCOjRE+agDxmfUjl
	BlM41xCeh3ib/39oBAaUW79O4MElyxqkdeShdEY=
X-Received: by 2002:a05:693c:87d5:20b0:35e:7bfd:4613 with SMTP id 5a478bee46e88-36a42425470mr24210020eec.40.1793811467022;
        Wed, 04 Nov 2026 08:57:47 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:46 -0800 (PST)
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
Subject: [PATCH 16/28] Documentation/litmus-tests: Add hazptr drain engage-wildcard test
Date: Thu,  5 Nov 2026 00:54:34 +0800
Message-ID: <20261104165504.2430480-17-kunwu.chan@gmail.com>
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

Model the drain engage's wildcard defer: if the engage reads a
slot holding a wildcard (an in-flight slow-path acquire), the
engage must not complete for the target address.  The smp_mb()
pairing between the reader's wildcard publication and the
engage's slot read forbids the completion interleaving
(herd7: Never).

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  5 +++
 .../hazptr-drain-engage-wildcard.litmus       | 44 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index c2bf20fa4092..daab126e45a2 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -110,3 +110,8 @@ hazptr-wildcard-flip-escape.litmus
     Test the in-flight wildcard window of the single-pass wildcard-flip
     scan: a straggling acquire that published the old wildcard after
     the final walk cannot still load the unpublished object.
+
+hazptr-drain-engage-wildcard.litmus
+    Test the drain engage's wildcard defer: an engage that reads a
+    slot holding a wildcard (an in-flight slow-path acquire) must
+    not complete for the target address.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus b/Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus
new file mode 100644
index 000000000000..0cee89893dad
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus
@@ -0,0 +1,44 @@
+C hazptr-drain-engage-wildcard
+
+(*
+ * Result: Never
+ *
+ * Models the engage's wildcard defer: if the slot holds a
+ * wildcard (transient value 1) at the time the engage reads
+ * it, the engage must not complete for the target address.
+ *
+ * P0 (reclaimer): unpublishes head, then reads the slot.
+ * P1 (reader): publishes wildcard (1), then replaces with
+ *              the target address (2).
+ *
+ * The smp_mb() pair ensures the engage cannot observe the
+ * target (2) while the reader still sees the pre-unpublish
+ * head.  This verifies the publication ordering that the
+ * engage relies on to defer when it sees a wildcard.
+ *)
+
+{
+	head = 1;
+	slot = 0;
+}
+
+P0(int *head, int *slot)
+{
+	int r0;
+
+	WRITE_ONCE(*head, 0);
+	smp_mb();
+	r0 = READ_ONCE(*slot);
+}
+
+P1(int *slot, int *head)
+{
+	int r1;
+
+	WRITE_ONCE(*slot, 1);
+	smp_mb();
+	WRITE_ONCE(*slot, 2);
+	r1 = READ_ONCE(*head);
+}
+
+exists (0:r0=0 /\ 1:r1=1)
-- 
2.43.0

