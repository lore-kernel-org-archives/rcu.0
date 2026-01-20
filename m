Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0743D51B
	for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917921; cv=none; b=XdT6Fzo+6ViT4/QJRDiFUwz5LgR5QhNVABpD45NWjQRmMYyV+YIPIFG/Z15lmJMB+wm9W+oJbjfZi27J+8p8ghB5gR+dFQgRvZ8L/eZ0qYXURO7odhnmQorPPO2Xgl6Oyt2qPO4X2ZLGdxoKQ9Aw1ZwDI7X3LD54ooBr16YuCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917921; c=relaxed/simple;
	bh=YYayMGV6ngRY7nmSsJrP2TzrNdW5dR5oIdqIjfBi5QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWWV2FevmcUZFeHNFTOF0BYFvUx3dtX8HdOp5GeOlf9A93Ycf6TunSlqaC+KXdhfrGnmR7IvTllbBKUyy+5n0jos4jrCEahE1Cof962vgdi+oK0Um0SO9+Yh97YqAtWLI58j8m6kwOtCfl/GxQBZFOMw807uU42VMVF25T9m6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNQovWsf; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNQovWsf"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a367a1dbbso85423766d6.0
        for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 06:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768917918; x=1769522718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ndl0X5WSxnCKWziNf/kLjxjZJLIqLpW4gsz4OqMKe04=;
        b=BNQovWsfeXA+HXOfpFAxQO6BLNf/v7Nbo5XRgXSf6RGHWSS4ElCdaPscrhAPyou1Dl
         Gg1xhxxpwfwxm3ttBdoyKV7G5UJ36CpCypZlhV7fh1Lcvh+79/QAU5ywdu7IsmZ3BwKe
         KPITOKn9dcsxkdrcpeJiYKg42iGzBuPsbuEzfHVTrIochu2KPtaV8P5Ta+BEV+AnBgUF
         /Bvsy9R93rf0K4DqBOTiWH7pb90uZgI0OfgeJiuahUHaFevL5hymEKXGx0C8kmrT7M3z
         n2HXpa4+y+Q+DBa/7Cd1Nnnom4DDi8JaKAGOT1WdbdOKDv3tA1JFijQOd2F3u4uqawfS
         oL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917918; x=1769522718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ndl0X5WSxnCKWziNf/kLjxjZJLIqLpW4gsz4OqMKe04=;
        b=b9MAXs6wU/G4p09ysikfLYA9YL3HSfflscR9Pr+UWgJVku5u5hpCnUBxYfcQZyCIFh
         Ofl6ZMyqbbLwLUyyULr5sSMS1IE79iRvy/YUaOKxuTVrEX/fqnWPt9iXqDQwpinGVs/O
         IV+NQZmqUad5qPtCwK3iRA1jJRHWXpSL+j9CFyejhiS/eGkfkWgW0jIWx1qXH6xJL0mK
         ECBr8axk8oQYpjlc8W7qe4qLOnWtS4d45nm42D5Dg5ZwmkELGSk27pnFEx88o4YRB4w3
         QA50HQZDfQZEpgYVr33Y8IQc+RXkjnhmKabz0MOzuPtNiFJtZFOgRL4VdFmBZZCHvEbg
         CC6g==
X-Forwarded-Encrypted: i=1; AJvYcCWw57udvu2vblyyXymQo59k2MmKqvo6PH0sIJyCskBSXPF7TMxp3Ss2X/tSXM/akunpMpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHfGn0zKgt00NnBjE1ujf+lLaAo4Zdvfk10BgpT7OdUI2Mc0+7
	8ZxyHF4+JpYeoGSM97XUDS9XAtR89WCNj5/oHubUEDtaypO0690qttFO
X-Gm-Gg: AZuq6aLcSCu0lcyy/Qbl3OPPo3D+3BP52FwRwJDG2SQACzg15nMpdEtgjpq+4Hc9C6n
	7DomHwahScufgFA2OU6/KH9bhVN6G/m9q1MLXk17gc0mpTDQOtwwNnI9psEClwrbE7A14Z8mDL3
	Axj8nyyfyIDkKNF+lE37Et8ovgGXhbNy48L62SAGq251bUgjuB+DN4tZBj2SYtJqQ7No/fBvmvl
	d5IK3NPLgWz98CgX3eb+0el5GudIJpNWzWo9GQyht4TT4ujEcjUpMJPxF3jfJ8PEPDiLf8KRR9z
	hOZcixGNdvrpNAiyawFRa7ChD/GlhFQjAA7PzryrqrST95Rb8lkghSsWmo/YPCSYQwqk6pHwUyL
	tu4r2UX8AdVVltj1qh7ezRIjwXeS37tv6N0HOKSaZoI3yU3DlrS+WZsZ3ejuQVA6QMwvQMuUYB0
	HmWOBtsgyJoWIaPn0Bm6L3nSP6auGKSgG/AqEYCBP7yXI7jqS+LzNvwadiHol+7lW5NtW97BcWu
	wkJz3yom3PpczU=
X-Received: by 2002:a05:6214:5009:b0:879:d0eb:fe95 with SMTP id 6a1803df08f44-8942e421a04mr188044366d6.11.1768917916142;
        Tue, 20 Jan 2026 06:05:16 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e45a7sm109499356d6.1.2026.01.20.06.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:05:15 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 519B7F40068;
	Tue, 20 Jan 2026 09:05:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 09:05:14 -0500
X-ME-Sender: <xms:motvaQzVICAww-oRCZoxVPm3iA58WW75ffbAuD3VGZ-JeNrA3KPcgA>
    <xme:motvacoWuGYUsItD2OfYg1vxbq97rmJd1GfhzTjz3f7dylWWy6A-NgQs2E4HEeaeJ
    2kBNq3Mco9zWjhV79cVCNIHMMTQBTTXSS4jUCoOAluCqXGtgf3_XE0>
X-ME-Received: <xmr:motvaUiI13lDsGCj2zVEJA7AUXebB_vyVN4JLyX1vbrn27zoukhi6-gM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeggeeukeeghfevudektdevjeehhfekffevueefudeivdelteeltdekheejgfeiveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:motvaWXo84i66k7k7re2ABUJLMs92aVAV6KLWpTYIgCv3EdhsF9PIQ>
    <xmx:motvaUEako88WxNGtqMi3dyxsy2VeKv-NLP6CFlGYuNJ6C8Ql1YJBg>
    <xmx:motvae_yxjoVrhwrKv-I9W0VhQC5swLt1G-04a5u2jo9DVCy2txsZA>
    <xmx:motvac3TPZ9UCBaSbJT_Md0VGHmPlgSkwyzLEKzdC2JdcNfwNUd-7g>
    <xmx:motvaemzkBjRSvvUqNg4nrP8Go_bXL5NmU3eGAoG54W8uEA4oBCl-9KS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 09:05:13 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v2 0/2] rust: sync: Atomic pointer
Date: Tue, 20 Jan 2026 22:05:01 +0800
Message-ID: <20260120140503.62804-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've already queued the first 3 patches in v1, but comments on them are
welcome as well. The RCU pointer patch is not included in this v2 since
there is not much update and I'm still hoping to get some reviews on
that for another respin.

Changes since v1:

* Add a clarification patch of CONFIG_ARCH_SUPPORTS_ATOMIC_RMW as
  suggested by Dirk and Benno.

* Add support for Atomic<*const T>.

v1: https://lore.kernel.org/rust-for-linux/20260117122243.24404-1-boqun.feng@gmail.com/

Regards,
Boqun


Boqun Feng (2):
  rust: sync: atomic: Clarify the need of
    CONFIG_ARCH_SUPPORTS_ATOMIC_RMW
  rust: sync: atomic: Add Atomic<*{mut,const} T> support

 rust/helpers/atomic_ext.c            |  3 ++
 rust/kernel/sync/atomic.rs           | 12 +++++++-
 rust/kernel/sync/atomic/internal.rs  | 37 ++++++++++++++--------
 rust/kernel/sync/atomic/predefine.rs | 46 ++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 13 deletions(-)

-- 
2.51.0

