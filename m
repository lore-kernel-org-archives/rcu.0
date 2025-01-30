Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C91F1906;
	Thu, 30 Jan 2025 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263886; cv=none; b=bxhgEXjAU2ede+vEud3WXlQtDKYpIsZHxlxV+dKH+de8CUy0NRw9VUp0jLDsZ2eEd992IRn3zc6xYMq4dxsEr7wPnSwXy5TspmX7xrxjX4HmcPRuHewvjtM1iBrm/uD/nU668Mh1e2h/fCPMFYh/M9NUaJlsxpqTKqO5mT0vP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263886; c=relaxed/simple;
	bh=ippHctWrdp8yKiQAmqCZWX4hTtWYZ0UdDEpmXJYn4MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKxZA+4PUUSC59nobgpHWTxdZLshdHgaoAmoJHL3zT4or3aI9Nn/JraRZ98Wvc+4UDm10p/qIdtGTyCJBP+wpMakn1iYHs1ZK9idsnq4LPcftJ6Fnf0ruZdXAbY0iz40b2HiWcz2mMfWCjSrbak4JVDDy+xNgB4QSg0HFCZYOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwS9aXhR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwS9aXhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B655CC4AF0D;
	Thu, 30 Jan 2025 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263885;
	bh=ippHctWrdp8yKiQAmqCZWX4hTtWYZ0UdDEpmXJYn4MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwS9aXhRqpeS264BQ3/XShg+2vDsOU9Yr/IO8GnebKMhRvp2KpcRwS2yWDp+by6Oa
	 Pf9dSRy8JyEpPedHepM+0FKSa56T0H15cSDxmPnqbtZdY+qFQll3Rg57JqzTucTvZq
	 0zhAQN7hB2bMS6bb5N3uAs6luRHxGllat3KHvlPlutEEpj/OYgS9zUvyMS/EJgMjJS
	 s2xm7yb2yFzX9o3vL/Kf1B8+x8AWqlTAOgeWgzw7txhqNH059WuoQFZ6XvWok2pOx0
	 7NC6LLvc9XSP94g4/lQJtxeyRd6/vXQIX/rP48tVhs8sB8rHG/RS2nlbjSbutxQh6L
	 tW7J7he3u+BCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 818DDCE37DF; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 05/11] rcu: Trace expedited grace-period numbers in hexadecimal
Date: Thu, 30 Jan 2025 11:04:38 -0800
Message-Id: <20250130190444.1652700-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
References: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
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
index e81431deaa50..63fd8aa99af7 100644
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

