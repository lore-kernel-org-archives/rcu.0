Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228933A032
	for <rcu@vger.kernel.org>; Mon,  5 Jan 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616983; cv=none; b=SAK0oIWevSXvuM6+zRnPJfT3c3FgiHQYJ7fk3w1o4xCSPTlfnDmnc0inJQVQmGsSG3a06zfA3xkURxuXFLJ4fsBMVyg9EN296fuNT/3Od5bPiAa188BiaEzWC3JdiE+iYOi3CUlmwxTEHRypSHSI0iIPEkLfEPofX61LIJ0KuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616983; c=relaxed/simple;
	bh=FGf5TitsuCIz8KGi2Bpi+wkc295BjgenmyozEMleR4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3zL9BXfonKjA0bOD1ffUxhxbV5vUSASabeKlmRBKHGI1TxiQRqeNZlz1op+mmGQ5GcGosewlbJwUGAuGhjmFgYmhWxHj8kMgYEoT7CdzkhwcnQp+r27s8I5D2MMNUZj1G8vnpWWMx5QZ7/3Yx+OuAaIOGWxYc+20j2R/Vfo2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FnKdnMVc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnKdnMVc"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso60148165e9.2
        for <rcu@vger.kernel.org>; Mon, 05 Jan 2026 04:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767616980; x=1768221780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7t7KDHljyK/sic72GXX7lUQ+DJiATraWRrWBCTnABgo=;
        b=FnKdnMVcP8Tb4CPr1urWFTvA/kobCDM8eeMUozL3Y0rTbWmE9PkPeJhxRY6I0WAS67
         sVnAtBxxzm/T2pXf084azttlfaBXEDffN13zKz6qCUaHWrzYs3imlNgYo66nkI4UBrU/
         xu38070Gk6YtDG4Ci6Vj3ANHqLb3Z4uLqcDQdmlK4GfgDYK8UACyc3m++hkpCYQtTnvu
         OPc+AwvyN5yEtwCHgY2QsUcZ1ukRwH2eZRRu7gO+L7pjWvWsAG+DXjLtUB3eMuzZFk/1
         +SoKg4AH+bSI2AHCq5JTm42sH6Kbdw4hWEc1zHMEoztIz9a0q2EghQyxnIpMKhN1Y1un
         L41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616980; x=1768221780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t7KDHljyK/sic72GXX7lUQ+DJiATraWRrWBCTnABgo=;
        b=BoTVhXQkHoEad00jToJAcLC7zN84FeG7Oe0PBQkRYRM9d76x73J90wJUcIAfw3FSMz
         d+R3bBY9Y8IAYxkg+LLnDFc9cnkaVuNx9LLQ0JyAJpkUy2F/vv5no1azT85WWhQx20Au
         1dyfB2JVTkSp2hnBknJklPMX4HrYWCQCmbYjQqPNyoG91SgSi+03FYT7KEWHgmefHcx8
         WUu8Gv/RHGoy8ozFgEuSwJVz6HYrM2Bxfqk9Ml4WyuBEyltYoByfClav56tE8C4LPf3/
         /SCXk83HBbxzMOYSL4O4xiFHXsViYFIbxV3MMozIGoS/Tj/9w4U4r0GQ+XxWl5AOVQa7
         F3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU2dkr4fAn2CwXDX/uIaFynR8+tqNwSXcDBbirxmzxx5MdYiuy8KJjfP7iE0hzLzcDvnSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+g2JoRO0zQoXqniK0I3lXep9NytHf3CkPTPRQG9uBDnSJZ6Cq
	thkrWe1I4LyeqqPe/n767PVfssMJQzFVXWK6CtPf/Ei5BBcEwceYzQK42Lm32YzcqnRRln/2gO5
	l/U5gZEuiTppYXyp0hA==
X-Google-Smtp-Source: AGHT+IHg1tiBcOrQitMvHuwpbRsE/0LlTWdft24XBVdcCbUxxz09Y9eVB5o0o5seEbWotyhUbJHrsxbsjq9sd5E=
X-Received: from wmbjh12.prod.google.com ([2002:a05:600c:a08c:b0:47a:9505:f0b6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a413:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47d1cec8f39mr473625575e9.18.1767616980283;
 Mon, 05 Jan 2026 04:43:00 -0800 (PST)
Date: Mon, 05 Jan 2026 12:42:29 +0000
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=FGf5TitsuCIz8KGi2Bpi+wkc295BjgenmyozEMleR4o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW7G8PwK1nwyas6YUKFOxu1jkaetUmUBtBEZSw
 kTitvWLiNKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVuxvAAKCRAEWL7uWMY5
 RjHQD/9lu43fZv1LfUsKMyBz5ryvjEbdSWL2DdQYVvE0XT2iJx7lAu2p21xL67N4HSr5sOle91K
 czNFieyrGUqA5GLcU3r9sqskvrlqpaU0N1pwxMWn/EoKwkc6NZ6cnAaugdI+TZYM8KciNdZ1EtB
 Ehzukt34Hmpk3fejH0t4fY7r9qgSq8KYrLOgudCCF1FkkY/QOF6pxLlzctTEn6jPWRKOn11EQQN
 /wpCsAzkbVueWiRIS0oXAPS7yWk3OQ3fLi3mV7He8Eqa9GzFl3Xbe7rCHRN3eFYnw4M8ONDit+a
 PGc/ALrc0QZeJ97FRlY7rhRSm9FSqDqmlQ2rR7TdU3HYibS5Xh0vc6SFTI4g6eVs5eqvf3EE1ZT
 8yNwwo/IQKdcr+3e5om6/8K8CGRssZAHTcUfwMcAffCx3fIpKlYeyYteKPUkYMSCjIjZwQmhXS4
 XNPHCzjZF16fUypUsbxt0vgI8SvHlRvrwr+Cd5y7JKTXPsjOMBvgD3cbtAsXem1L6xuToQbvLBz
 VkVvPv1oGORAPKCBP73AbEQPVvvCXxhnrq5BvNJaumv/broTWinmGg5wZcSOdC9WiqDqWdjYMQN
 HiOkbb8aXMQANo+lqWXJxrAPXII+CxDU7WjD6vsmy0kUXPav5pK6j2Gie0eL+LAfnN/qHbSQu68 /FVKWm0f8Ors5WA==
X-Mailer: b4 0.14.2
Message-ID: <20260105-define-rust-helper-v2-16-51da5f454a67@google.com>
Subject: [PATCH v2 16/27] rust: rcu: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
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
2.52.0.351.gbe84eed79e-goog

