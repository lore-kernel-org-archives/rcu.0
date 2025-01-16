Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA722442EB;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=RISzzMG0YKgbKS43yMAH6R0W+jEh1bd/f9NjvlPf158E++w0iOP1aNc00Q/wNJl5D/V3uX5RE004j5RLPj9P6K92wBuDfCTYA1Bey+PjSJg54UHFheYHJOdp+p/2M/Y1i2PaWklGdF9Hr0pw+0QSKLm6UksmtsVFDWd2atWlrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=hN3ajggYm+37wd/iR3tlAlMEp4lIJ8U5kBMAt2Et/G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPI/OdQaSEHsj45TNRfmNR+D4n/FZsKDEPJNQK44WB25BEn+OaXACs36ABLAk+C+7McPRbS96GIZ/ATb+lcF0I3Lt63xkYaiHAlHAiVCI9n1GCvpK6w3v0XcnPW5QxKB0nK0olflGCzDfgzPEsYN8Eb3DJbm8lmEizbnbbL79Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8mTWq8z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8mTWq8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C756C4CEE7;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=hN3ajggYm+37wd/iR3tlAlMEp4lIJ8U5kBMAt2Et/G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8mTWq8z+Ll8Ppbz2cGxixSyiAVfSPGstPf91t2c+938C1xysfnYBViLgvPyjuQrT
	 IddaaOMXSpXd/fCtChaE05075AX4b3XpdSNtU8Bf3/QHDKnbgrWkU8wBmUxHoqNqx5
	 wu/IMT1aCziNrOQd66BtROIHzLD4HN8z8Y0qgBbk5jgGBL753giFY1fFXNmGPVIsjZ
	 aeAjalEMRQOpMrhg5DBPVDfxAdP/8CRQcY0BP8l4fOUxxTIpkgHK1zNA6xHWyOSZw0
	 YcS3PD5yhpCfIkVjyyjqFuUNE0iCtXkwYo8oOjILVZWvsuUADJR3YXD7JLh739ingd
	 X0vbJ4TBTOocA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AA5BBCE37C1; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/11] rcu: Trace expedited grace-period numbers in hexadecimal
Date: Thu, 16 Jan 2025 12:24:28 -0800
Message-Id: <20250116202434.3783613-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit reformats the expedited grace-period numbers into hexadecimal
for easier decoding and comparison.  The normal grace-period numbers
remain in decimal for the time being.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index e81431deaa50b..63fd8aa99af7c 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -207,7 +207,7 @@ TRACE_EVENT_RCU(rcu_exp_grace_period,
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %ld %s",
+	TP_printk("%s %#lx %s",
 		  __entry->rcuname, __entry->gpseq, __entry->gpevent)
 );
 
-- 
2.40.1

