Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C82EA75E
	for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643581; cv=none; b=YwdsOAaCknf3/5UKrabgdm2lO8Hi3Qoi3+4JiX+6qL97WRoqmNkN0jR8kSSNBnKy0393nhf+pUwmqkGPT/iAGDFVAB52PH9gjs+aH69eKbY36tPqc2qUsGsToGxEqIUqy31UzJJpO3ROoZKiWVMAj06Zn5uefCuPFqApZuWXlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643581; c=relaxed/simple;
	bh=D8IHOpzdpv4jpNHqY+5RxyIP01Gxc9I18RznU79aOOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHx3auVB18E9W9sMzEIonkheaJ9W2z5KdaKYfyHBuP22v4f9HwlBA25hMcRzXDwPXwHe/JCs3pjd3oDkLgrhDVlvxs6JAP4O/VFaieWoIPdppFxL8zvDQx6/LBf0d7ga4wwt11iLk6ZctPAiTfcT/AxXntKgBNfTRxFaiT3VDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PenX5zZ7; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PenX5zZ7"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94130b88642so229791241.3
        for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 15:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643579; x=1770248379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5K4fiuuxH7TZZ5P2nOc2at3WjKzG7Xg5l87CzajWOME=;
        b=PenX5zZ797SswiN1updnUZ2P1VDfhhc/dnpZRdmo8xpeWvNoIVvAZ6/I7GxYQKhb4B
         4SJpURB2UITSQNNDcJHk1YajYPUvWJt4IKJ3x8oMvG9shHMlffaQkKoUIpsKgtSS9lMs
         YkVcQegbbMBDrDe5UcfVqynWOhGPLrI9ZG6KWtr9APKMsQnpwbetYAC/xQRT4VP7PbW/
         vtLFZpYrKanuzNT8Ks7mroPhdDrH+GROISMP+6NnIDGyhHHYQM2Y9nyfI0ZdtPtq3gyj
         dAhiOBK6L9gN3TaUjvIiLcdDBOnhHfsWT9KAUFobLKSBbAeDqWSS9X71AiGOcqCNpQVL
         m+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643579; x=1770248379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K4fiuuxH7TZZ5P2nOc2at3WjKzG7Xg5l87CzajWOME=;
        b=LHnyXwiyz3xxxHl0aiVxFWnM73AOFOyM4bNKVLDJmLfAMvzA4B+i9s51PM8rA+y+OE
         7jU69aElM9clYMet9X2YyE0SoTd7narKzPVtSNQm26Tuh6JqgEiBHzJ0UPm1mfh/Se5F
         DcaPEGwkT05KoCi7R4l4yRTL8J2FutgoPtCx4hkJBep7mWrm7ON7KaBGOv3KTU6PTHKK
         AIkFAuIBEYF9AwNwxfZnmfAhVVgOrUqskavBDxdUomRDsIFgaKyu4JGOZ2d8h+CC4nCV
         3cz3AHvAr50FRnXE88ABkkinoVSx2T5p7YlM3Te+teK2ImnZC4JvTuYMNdQRAc+RLTby
         cVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWogxqbHAxX2d1gllczlrKLGFsHXME3MoHbplHouFkuGfp/vm/bCoG5cyIBrGVRJapPJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfygMZbuRJH6HVFE4SZveSwRLswFD2M3lrrFTxfcsPHnkzHJL
	1ktwF5/J73WYuyvMk+uJ80V+2HOPZvUsm9KiobvwnKBE6/B9B1SVh1VT0nz+hA==
X-Gm-Gg: AZuq6aK76nQch7uswuXU7eVTMuvx2r3teTOzYM51hU+uYiPlr+c6sis3R+D0s0Z9D8W
	5LfZq7ibAp7SafqEomXKCxotTE6h1Fkpxxp/sRzrNPJbTpl9TgyhPJyTOZ9nTxRVd5omcRYxNEI
	CkN9PrAjUMjJoZvEepadD4K3HzsdZFAuAguPl1NG47QnPZqpiIyUxxcijToskL78QOeL63uoAsX
	bhVHlTftIp2NjILN1XAMv6gj1MX8Sl8Lj2mMvlIt149lwmTx3v8etJ3gkBi9oTlYK/Va6JWoXWD
	BAw4K0tO1E1vQy9hNJfEedqxCK0PUpqj2IL2u35nJD2f4ynhYFRDQary2WqxKAIMbjQ6lz7nyya
	JSRLR/6jCChGxMutLKzwzpnsHM1q0pJIsiBohqARgcnOxzuCLHnMpQBHBHHxYAFdMRugeptex28
	sDgWESn5VWgPbnea2shMat6iZC8YQUIEl2SadpuRRiI1Z2YiUNNvJnUalfloDxpYBVbnzP9v9YK
	rD0p7ZwFtvHLfw=
X-Received: by 2002:a05:620a:1a9d:b0:8b2:ea2b:923c with SMTP id af79cd13be357-8c70b84a575mr922371985a.14.1769637222303;
        Wed, 28 Jan 2026 13:53:42 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7ba79sm256119785a.11.2026.01.28.13.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:53:41 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1F6CF4006C;
	Wed, 28 Jan 2026 16:53:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 Jan 2026 16:53:40 -0500
X-ME-Sender: <xms:ZIV6aTDN3a_kIhhZ2H1nxH6f1S4IEsaoD7jvSaxwzd8rl6LSb-51mQ>
    <xme:ZIV6ae8SosD5jve8mF2--YJpnqUosLSGl-UqrYYHL5uMtJwOax37zhE4LbLEByHC5
    5q6uPagmqo4og9SFtjesT3BdNHUZyL40IUwzGLfnpQ0ZD1XY-kJIQ>
X-ME-Received: <xmr:ZIV6aTXpXyuhOlbUt0kOqjc76SyB2CDqB4X_313KDtQ-9HGBSphHTqdf3S6nO0shk8Hffe0N65GYW8hB-haBf91-IlD-Fjwe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepgedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    rghrvhgvsegrnhgurhhoihgurdgtohhmpdhrtghpthhtohepthhkjhhoshesrghnughroh
    hiugdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtmhhllhgrmhgrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghlih
    gtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:ZIV6aWtSq9qpHrQQCLvMPW4tXsR5-IUpcyz34pT40M6ooIQlQzinsw>
    <xmx:ZIV6aVzgT15Ft9tGPhtPB9RPB3-O2jEcLd8mw1a8J94NYFkJlRhxCg>
    <xmx:ZIV6aZQf-MrcPbQmQCtRNOHpqgTiVUXgSjOrz_ajV5t_gipytjSxKQ>
    <xmx:ZIV6af-eJKAoKYj_3zRswIp9N1j5joWZkNGg4ZIHbXysKfMiHTKuDA>
    <xmx:ZIV6aXYaiGDuao_kQDt-XU_ZwwaVQZB_etcPSULeJAtBgaPK8LO6zA90>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 16:53:40 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Lyude Paul <lyude@redhat.com>,	Thomas Gleixner <tglx@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,	Stephen Boyd <sboyd@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Tamir Duberstein <tamird@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mitchell Levy <levymitchell0@gmail.com>,	David Gow <davidgow@google.com>,
	Peter Novak <seimun018r@gmail.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 5/7] rust: sync: Completion: Replace `impl_has_work!` with `#[derive(HasField)]`
Date: Wed, 28 Jan 2026 13:53:28 -0800
Message-ID: <20260128215330.58410-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260128215330.58410-1-boqun.feng@gmail.com>
References: <20260128215330.58410-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`#[derive(HasField)]` offers less code and better ergnomic for defining
a struct with a Work in it. Hence replace the current usage of
`impl_has_work!()`.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/completion.rs | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index c50012a940a3..c4af58924fe3 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -17,20 +17,18 @@
 ///
 /// ```
 /// use kernel::sync::{Arc, Completion};
-/// use kernel::workqueue::{self, impl_has_work, new_work, Work, WorkItem};
+/// use kernel::workqueue::{self, new_work, Work, WorkItem};
 ///
+/// #[derive(HasField)]
 /// #[pin_data]
 /// struct MyTask {
 ///     #[pin]
+///     #[field]
 ///     work: Work<MyTask>,
 ///     #[pin]
 ///     done: Completion,
 /// }
 ///
-/// impl_has_work! {
-///     impl HasWork<Self> for MyTask { self.work }
-/// }
-///
 /// impl MyTask {
 ///     fn new() -> Result<Arc<Self>> {
 ///         let this = Arc::pin_init(pin_init!(MyTask {
-- 
2.50.1 (Apple Git-155)

