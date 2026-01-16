Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09972D7DD5
	for <rcu@vger.kernel.org>; Fri, 16 Jan 2026 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578410; cv=none; b=BdWgzrrWlxMPeL7uAJhDo+oJv7BQCOqzRSPRHPWeNtElUBBvXoIyr7eIp35TpHBf6LRgsSAsc3bOqx/gwlt6Smq19fIL1F/q+1oahykJmwO7ceXqpqfWR6ZzPkfjAdabco8JKbhYU18tz8mvuKEjc1J78yw2CpUfhPCn4qGNQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578410; c=relaxed/simple;
	bh=Iz940EgkLfNNoe9mfYJ7T2Zz0bFCqg1e5P7kXk7aajQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fx4TGKZcQLcJJRRgqPmJoPrgomHjon1BykNykRgovCyZrdq787Z2zmDwuHEPq+kCrHHPNOvuW3pYIzs46FICU+XsuKJ4Sl1XYyfuXttbjBYO+XVNRA3f/1PItnOmnvwDRcz8FhLmiYmwhvBQ4NbIJnDfkJotIgbOAdK2zajlf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2up+iVs; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2up+iVs"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42fd46385c0so1420403f8f.0
        for <rcu@vger.kernel.org>; Fri, 16 Jan 2026 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768578407; x=1769183207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C7r39NKpBQyuKnGQ/TDPTBGIStYQI+zyUw1P+bFsh1Q=;
        b=T2up+iVsAPH/GMQhnlKrOurAjqhI6eevUakVlf7d16ZDJsoKr/Vdis1n0EwZxEE3NV
         zO3A1bfxnu4CEwJ8RDtrhxrsrIwK9riFVIbrx/+3hscvQtfUVudEzHNwr7HVGPiJjfPZ
         TtY1phTIWcuDvl6NJJDeSptizowVH2pVgwsjNAhD/0fPXCdLDkGQpy8UuKLnxxpFTws1
         kRjg8Y+T4DTRk+ErprVtsppC5zTPtU4mXC3OcBlhiBQKLkhJIhiuIJ0AklyBHHqv4j+h
         5GPlrrcbhI01MDbIwkqYzRPDj/fia01f53p2d56Pidup0FvxQlYsMOnU5H0sDtGZuqCc
         yuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578407; x=1769183207;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7r39NKpBQyuKnGQ/TDPTBGIStYQI+zyUw1P+bFsh1Q=;
        b=ce2ZZP+YKWTA5CIqn1TXd2BmW3uH5I42ZXA8FfcMFpjHBjEmTR8FXH4PWhdPCHhw83
         eSpLSlkbYwA4kU8wsk/UnSXJ8ji6pqJa0Wwef4bekHeoKBW0p+BYgN/D87YRvEsghXAa
         9nZ+UVftiyophCi+beuQlv2DnMcsJqivaNQsZM1pPewK81JNQjqlv/xn++tN3b/KZUUa
         NjH49b65Ypg9jRps4mlDz9WR2Mixz+MbCMk9v39qJ8fuEg+cNxqfgdpJGaUcAYyWXN6d
         eEII/t4z3TBFV+r+lg8lGABjKNITB4jEI7m0HZCIo2BbCvfkqaRUWqDZYwhvOv3Sz5o/
         RlsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTMV2CCDXK+CcEHunMxzLpzpINzeUiXpZLSuqZChOxVeEhVZ7MkGVDjsEiCRKz5NmlsH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrxrbW5dMInCKWXCdsnbtuGAjUkXmKBV0XmpD4Mp7vbuPEUEw
	f3f5zmxb94SAErsCSEJtBZl37b5+auLwhPHcUBsoLfS79/Ray0CC5iTZ5+SXft65IxscgoF3Dvx
	cTkB92V2XvcKzzGPqlA==
X-Received: from wrbeh5.prod.google.com ([2002:a05:6000:4105:b0:430:f9ec:6c09])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:24c6:b0:42b:3062:c647 with SMTP id ffacd0b85a97d-43569994133mr3828887f8f.21.1768578407156;
 Fri, 16 Jan 2026 07:46:47 -0800 (PST)
Date: Fri, 16 Jan 2026 15:46:35 +0000
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFxdamkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Mz3aLkUt2k/Apd80SLVJNkyzQjQwsDJaDqgqLUtMwKsEnRSkFuzkq xtbUA7/6RsF4AAAA=
X-Change-Id: 20260116-rcu-box-7a8e4c9f2180
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Iz940EgkLfNNoe9mfYJ7T2Zz0bFCqg1e5P7kXk7aajQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpal1hu1HSF3Q+msN6rGImAxNE3it2AkIevWXWZ
 /iru81gV6+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWpdYQAKCRAEWL7uWMY5
 Rjj4D/9SMN0PJKBXhY8oL4Xia0Ru5guIiPAURyKUMkoBD/KRxn9D5YQ+be/2XdYHMfTdOrtDtP+
 AxfbKxlp41W0cnQFpIDdduf95OJNQMb0K7gfKQkAp+oF0oBn4GJQ8/6xHXaj0/w79PAH3P/5klR
 k+aYv52qWF22mgn+zodlQM/pRfLHk4nsrlM4M1o9YpX/aBNZn4GXcSLVVPsmHILAYmiPNPZGk94
 /od1Vx47vl2EBogv3K1VOK+K7n8jB8ZdwdX7y8tOfgCLfB+zYUueMMtyCiTWIVRb5yxtoXsWckG
 G1u0rRrm64ruZohLrcbj6nQPkVb1pxshdopXezmTCHXOWYudESr70W87vOkH36oLSwuSkGNn89C
 LDgf5wKklUE6+AumNylI4Z19jTQqIdmDqI/KFwwf8HKlgxvh95z6JHd8gcpNZzlWM2l0CF2p2Xi
 K0uNL7zpHTpIATk5FWxXkBzU2PZO9aajB9LmwBI1h0aHxvjm7acX6ZtfslcL3SuEApheQCqavd8
 4PY1Kd60fil4uvVvlq+Tie7M5mb5b3kWRAGtl/ka85tN0dOne7Vk55ruq1G+VHCEPZYkVR18cf6
 GNJHSt/DDAlcxyO4DT4+zSXzv8P8ZcLB9JJb7Wg7k3754lbpvY4FK/C1f5IQkYOa5CPgKfVD7bU PCC2U9FYULLdvxQ==
X-Mailer: b4 0.14.2
Message-ID: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
Subject: [PATCH RFC 0/2] rcu box container for Rust + maple tree load_rcu
From: Alice Ryhl <aliceryhl@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

I'm sending this RFC to share an experiment I'm looking at. This may let
us replace the range allocator in Rust Binder with a maple tree.

An RcuBox is like a Box except that it lets you obtain a &T that
outlives the box by a grace period. It does not allow mutable access to
the inner value (Binder would probably use LockedBy for inner values).

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      rust: rcu: add RcuBox type
      rust: maple_tree: add load_rcu()

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/maple_tree.rs       |  52 ++++++++++++++
 rust/kernel/sync/rcu.rs         |  31 ++++++++-
 rust/kernel/sync/rcu/rcu_box.rs | 145 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 228 insertions(+), 1 deletion(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260116-rcu-box-7a8e4c9f2180

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

