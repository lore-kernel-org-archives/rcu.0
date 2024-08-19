Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8CA17921D
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086797; cv=none; b=TdVDAmoq/+2HYyjsVvfDngwBZc6zn7wXOoRn1a9KdPCyxffeEvDynhlP1wbhvYILUuY3uD2AtDCU6K9rPPT6+KRwebhip4V6cLCWrIwk5C2diI0Yh5RbCB/f68O7u0k8wQ840XVoX7KjZgzDoSaTNc+1KWQx0DbCDfLrs6Hz5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086797; c=relaxed/simple;
	bh=r48ooCDVbXnk0XbE6O8YOHRSjTk6VzALjklAU/epoTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsHQWS5LN5Lyv/dSS9UU4Iyn16pJaBZWGkfyV5mPmNg74c01bMTxo58Ch2l6quIJQ+fnkOY+pZWQbVl6+kCxRxTFMxoWsPk4zpm6ekRBuM8xVacaTqUyyZ+km2toXzu118szknoVvz5xqYVgd6SPrHOvnBWD8R8JShc8/32B6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GmBOXbUE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GmBOXbUE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6fmJLHU2ICDJ8SRtSCreCySm5ljWtPm5ejMXhunTtc=;
	b=GmBOXbUEo+oAh1ZYDKbq4owtpJqNy3Sd74FsbnvHim+fJL5a4pvLVUZer2UCwiC7jebor4
	qfqWA75JMSl7ctV+KrmqEY3MoTXYx3KQNlMchcLFfLO5QqepWooMb4CpJcrkjshs++7Db3
	ypWenZMjIBdKJdv9TXKnUb9KwYVJMII=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] vmalloc: is_vmalloc_addr_inlined()
Date: Mon, 19 Aug 2024 12:59:30 -0400
Message-ID: <20240819165939.745801-5-kent.overstreet@linux.dev>
In-Reply-To: <20240819165939.745801-1-kent.overstreet@linux.dev>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/mm.h | 7 +++++++
 mm/vmalloc.c       | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..e23516d197d7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1193,6 +1193,13 @@ unsigned long vmalloc_to_pfn(const void *addr);
  * is no special casing required.
  */
 #ifdef CONFIG_MMU
+static inline bool is_vmalloc_addr_inlined(const void *x)
+{
+	unsigned long addr = (unsigned long)kasan_reset_tag(x);
+
+	return addr >= VMALLOC_START && addr < VMALLOC_END;
+}
+
 extern bool is_vmalloc_addr(const void *x);
 extern int is_vmalloc_or_module_addr(const void *x);
 #else
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..2bba32d54fb6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -78,9 +78,7 @@ static const bool vmap_allow_huge = false;
 
 bool is_vmalloc_addr(const void *x)
 {
-	unsigned long addr = (unsigned long)kasan_reset_tag(x);
-
-	return addr >= VMALLOC_START && addr < VMALLOC_END;
+	return is_vmalloc_addr_inlined(x);
 }
 EXPORT_SYMBOL(is_vmalloc_addr);
 
-- 
2.45.2

