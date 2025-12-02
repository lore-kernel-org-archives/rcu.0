Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59ED2FD671
	for <rcu@vger.kernel.org>; Tue,  2 Dec 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704313; cv=none; b=RGkq5kBnQQ0t2Cgk7f5SYwFUUG7MRXmiPAIDJSFHbWEaLwELfFi7F+OTR+UjUiMmvDLnzGzFtcCKXcGu/oz/BuEzByVtFogdKHfTRD+VoysBPEt1XJfUT//Ku2H1RzuEkphmPiVEys3De28PPxiswmo9f6xMcsBxYODnMaDbauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704313; c=relaxed/simple;
	bh=KfA0aYktAmVEQNOHs/gAJiG3wUVa/u69tlizsxjAJZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhs1D5P1iEibJXCfxKXZ0/QAN2oeiM4Oe6s/7FakZDlL6zxi9fvVWRw0GZ5MiYK4fVVHcpoZF5pHPouDEoiJDoHLEbbyHImgQcsloeiJavus9D/xBpVOJJRWPO31psHejhQ0KYHQcUraUJs70inki5GBd/CMiu5TkeYMpH7RI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imfkV4aE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imfkV4aE"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso1154175e9.1
        for <rcu@vger.kernel.org>; Tue, 02 Dec 2025 11:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704310; x=1765309110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRI/D7GSmJeHvPRj/LS4GLskzfvRR4C+zfs7kuwZ/dY=;
        b=imfkV4aE6TY0w3w5buzfapGBBmDGXPMPAw2JoHnc1UVpWfKyOS6HUYtje1c03vSeJT
         TzBkFX33asmmm5VX1Ch1F3xSCeA7y2Xj1d7IfYSY78ptnJAulsfhXkKZgegbB6pMbl5r
         7v/6M6MG0dDOGTmwkFzfVbrXbe1/LugC+b0WHOJyClvVmluDR6igyZkxtYYNOuV2Hwwp
         GGbMgN8V4YTwXgellDNFxv+k5SttOtcgwhrqqhMjohMiBihfqesjFFevBdZHmdhaTMpV
         Do6h74HNxxr19c+pD8RTjN5YPJI971KgEgkZWeqGHmeqtXOpK7kd3p0rCi+2/qIQtT+j
         51WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704310; x=1765309110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRI/D7GSmJeHvPRj/LS4GLskzfvRR4C+zfs7kuwZ/dY=;
        b=mPUPuZogy3GiD+jqSbsk4PgVSxBAnUuxEe5lO+mbv49dpWa4S701C5T0WR9uyVC/gD
         X7wOvWrAuyGFHNvywcR/pnfCde3ae8Ala7+Qe4JGdNgkUAObdpXy/8ZaGqX6/7VgeJJx
         UN3DBaUGpYmyxipi0RRMc4qA0tmwy4BlXbScoyimDD7/zsL46seoiGvk4FVcbTHoKPV0
         7Nv+jCwr8dN+7qG5ND6U0n8v08C7KZuXt1+yftPS6q9xQsvcKUZbS39p1ixZ9CuuK2Hi
         8Tfd3zuQoBYv+46WT2eXyubM6hMDCX1KPjUvmxOWcbii9g1mrdpZU6Y6PKUlnqYhMmBX
         enZw==
X-Forwarded-Encrypted: i=1; AJvYcCUPl3PaFONKlh5tAQOHDBHO5KtJMv1ld8YdWSAtFAXmEARXKeMkTiVDLxv57LHxxmFI5Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLXbcJUwNyhH6+xheFc3y8YDqUEAAEkCz7ZhLb05bYdmbxRh6
	3SPhoDskovnarA/Hjw8Ey/hQPlGu3HBUqVWOEr9zIEA9MGzFrwpbSpRx/Eo6MLx7C0aH3qJkxwY
	PQbqM2/CEzQbvCW9WoA==
X-Google-Smtp-Source: AGHT+IHKwYwldcWP9HsSDKqCx/7sgEqR5Z+VgtB3rIj+E1+fJg+WDt6u52ebxKppoPkC56kc9KTd+Woi9K5cvBQ=
X-Received: from wmbjw18.prod.google.com ([2002:a05:600c:5752:b0:477:d21:4a92])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:358e:b0:477:a219:cdc3 with SMTP id 5b1f17b1804b1-47926f9a96amr48689665e9.12.1764704310043;
 Tue, 02 Dec 2025 11:38:30 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:57 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=KfA0aYktAmVEQNOHs/gAJiG3wUVa/u69tlizsxjAJZ4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AKA2Xf96afgiGb6emGi3PKdj8u6PTmzfkjC
 oednJNtBMOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ACgAKCRAEWL7uWMY5
 RumdD/9UzACEB4Q3wy9lLxRO9OjlxBFaWAUGdJuXJ+P2Zsl3+vQE/SP6caC/06J06Emqt1fOShh
 2T9R/yFvIpYuk7w1iZ8QQ3CzjPAiWbk78MrpzKkekGEtTr8i5sCta18KSztsHsJ8WK2kKsXfG5V
 4CUvuu6vQGtsX5teagvNKJzY8ySrNGdp81ODE1a4Bh9m1fznGhSHY92nrGZzW5r344N+6rjcwpi
 847FeNCkOIwoESXEb8uKCyCg1YHgVsFM6Q0tgKEt7qE0y3B0dMVNgQuUWI8GSykwP6sQUKuBTwC
 K7RroWqRBFYjC2zYDd6UV4eF6oSfI4Im4SLAupfAMmaLLVIpNcjOUBlMl8lFnFwEygykjFcUjRq
 cpejU64nBRWB1jZV9qNwdF9gOANOs9migVRrT+VMTqk7RSo6LNcxPpB3CuwMmdoyBKhIEfjH/Nk
 rWU/G2h6LacefsErKzpuZIXkJc79eXwX6s3QGph1BIFm/anEW9UxEgqjp7Zm1V9HR8fiQrQdwRu
 KMh5smLzD4Ecq0q7cX7kk3XiG3QFxzOuvzaM1/QhdD/aUIJUXEXqDe5eXlIeDG1odfs8P7n1nAI
 gOGdI5WclrywEDLp0o0iUoFbFpZwIszZbv3V5EJq6Z4NWIlTXFztEls8D7jl2oco2osyUqUQTGi rkhzCQiudX/negQ==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-33-a2e13cbc17a6@google.com>
Subject: [PATCH 33/46] rust: rcu: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: rcu@vger.kernel.org
---
 rust/helpers/rcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
index f1cec6583513497e996f74835ca2c6c3f4a8c954..481274c058577276e20093a1014fc49f4a40421b 100644
--- a/rust/helpers/rcu.c
+++ b/rust/helpers/rcu.c
@@ -2,12 +2,12 @@
 
 #include <linux/rcupdate.h>
 
-void rust_helper_rcu_read_lock(void)
+__rust_helper void rust_helper_rcu_read_lock(void)
 {
 	rcu_read_lock();
 }
 
-void rust_helper_rcu_read_unlock(void)
+__rust_helper void rust_helper_rcu_read_unlock(void)
 {
 	rcu_read_unlock();
 }

-- 
2.52.0.158.g65b55ccf14-goog

