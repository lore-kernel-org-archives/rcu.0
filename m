Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ECC367
	for <rcu@vger.kernel.org>; Fri,  8 Mar 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709934115; cv=none; b=U1ZnJUELm89Xk7+Ee7uhI2tuFHpH4JqXGTI1MlsCPDPpfGI5Cwifs7mdNt7L9TK/IFTqcZhf90lEMHm3/8bPlyIoq1wpA4WG/jebJSk8bBEDh9mx9fGFxMZBEkYPyosvlR9YYOcKqbRDC6t8fFQ0LBDErStYgkCDTd0ukCoFdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709934115; c=relaxed/simple;
	bh=0JuWA3MRL+6YQ5RV0GmmQA8TNz8PEJsZgfrtUSDOhBA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QvEYBU3q/y1ND6fFi2q/EZh0BEA8RJzjQprznYXBm63icrkqGUYr6wr8ko5ExquRbRcC5mWOvYaCxmYD7Vs52S/98ePtyH0gCPAUKrmWSEoPFGgCCNSSqSUNluCaMGsIQEi7vLbDq+Thu6HXfIAvpc/4tI/t7AnASyGezgmCTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnlLM7nz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnlLM7nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1FEC433F1;
	Fri,  8 Mar 2024 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709934114;
	bh=0JuWA3MRL+6YQ5RV0GmmQA8TNz8PEJsZgfrtUSDOhBA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=gnlLM7nz4cGivGFn9DfbU7HTiw5zMJChrytYo/FfZXW6p/l3jagDaSK2EZAFwoIcD
	 64JEj2lhqwli+/Y2y/KVWFIddnxmQrnfwQI/sHj66tJEsfYs2rD9dF/3QxDNgq7Va3
	 vtabL2Pvd6ksgUrpCJOMyC45pYZKnNNT0g9iijRGieYzsz/UPOiPzrnWn+7vEHlqqo
	 HY8F2R/4QhjpecmiP7B0rWUNKKR7sTM7i0rpHaQTkhDPtSy+0SMWvZEE7TODevCUFm
	 UKUxGehcQhDCFrl27GR4Pk0+aWPTO+QWdmp8JMgi0m1BWMi8VzFAPpcGyIDTzsvDFm
	 OxFXUHQyQQioA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 24B91CE0548; Fri,  8 Mar 2024 13:41:54 -0800 (PST)
Date: Fri, 8 Mar 2024 13:41:54 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: elver@google.com
Cc: rcu@vger.kernel.org, kasan-dev@googlegroups.com, dvyukov@google.com,
	glider@google.com
Subject: [PATCH RFC rcu] Inform KCSAN of one-byte cmpxchg() in
 rcu_trc_cmpxchg_need_qs()
Message-ID: <0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Tasks Trace RCU needs a single-byte cmpxchg(), but no such thing exists.
Therefore, rcu_trc_cmpxchg_need_qs() emulates one using field substitution
and a four-byte cmpxchg(), such that the other three bytes are always
atomically updated to their old values.  This works, but results in
false-positive KCSAN failures because as far as KCSAN knows, this
cmpxchg() operation is updating all four bytes.

This commit therefore encloses the cmpxchg() in a data_race() and adds
a single-byte instrument_atomic_read_write(), thus telling KCSAN exactly
what is going on so as to avoid the false positives.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>

---

Is this really the right way to do this?

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5319bbe8c982..e83adcdb49b5f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1460,6 +1460,7 @@ static void rcu_st_need_qs(struct task_struct *t, u8 v)
 /*
  * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
  * the four-byte operand-size restriction of some platforms.
+ *
  * Returns the old value, which is often ignored.
  */
 u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
@@ -1471,7 +1472,13 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
 	if (trs_old.b.need_qs != old)
 		return trs_old.b.need_qs;
 	trs_new.b.need_qs = new;
-	ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
+
+	// Although cmpxchg() appears to KCSAN to update all four bytes,
+	// only the .b.need_qs byte actually changes.
+	instrument_atomic_read_write(&t->trc_reader_special.b.need_qs,
+				     sizeof(t->trc_reader_special.b.need_qs));
+	ret.s = data_race(cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s));
+
 	return ret.b.need_qs;
 }
 EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
