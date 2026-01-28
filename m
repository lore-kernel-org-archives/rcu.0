Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A203338584
	for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643731; cv=none; b=Pra9Er6VsbkSj/+D/vCLQFctXMdMW5VrLMQuAobX20ogDh4SmtWUhaCAFjTSOFrXoMgWH/GcgSj/7H7yOH96NGRuKHTqTxKjxpX5uiDwuZuq74mh1FWrjjUeec//Khn2ehEOep1RQhgFJdiF7upeVmNVaXff6/DrHl6yEJgGzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643731; c=relaxed/simple;
	bh=sxpbpWKTZvxcwwFtu3C/YF5qkG3yECiILa4gEgaG3GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qb1DqOeHIumnpXpU4E6tpbaPhRUlq8GSsYKKgZDej/+kvYQN+6c66BEsO0x9VfCFqA29t4HlmBm8Sac6gZBZox39ZH2NDmn58LcYFUgvVIt+euOg05la/a9Bt/+AYVKaB166k12W1r4yRBVbd/wx/Hg03s/ZITi2xdAg59DiDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ksb7lx9D; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksb7lx9D"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5f52e500e89so373067137.0
        for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 15:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643728; x=1770248528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9rsltUJYSM7HaaCYyAzd6NhR6FQ1Y8lMhd5oHE/Kxmw=;
        b=Ksb7lx9DNkViK5rzUK4kYq7dfmnCd395riquXnv56ZUuB/tXwRF1y1MSbjMbm/FbfY
         woGT0WMlyEdBz08DnNPI5rq50z0xmknjCGoJkWGYo4EzXx116CTx74tsWqc0s/27L57v
         0W8tUkeG38658QJmHQIl9ibfFDvkrGmRsmTBDmAUFG4MZPMoSU4vHOtgS3ruiRe/7lKx
         U87BZNR5xBfo9mG04rVqGFttZjG98DPEdNYtOBpredO3RrENEu0f/UuXTxmY/MK3cc/q
         ZX9acxp5AekZgpT6i1hf9e9fniLuYpCaZEvnRc0oKGSsxzZfAzg/o1kY2IAX1iPGfZVd
         at1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643728; x=1770248528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9rsltUJYSM7HaaCYyAzd6NhR6FQ1Y8lMhd5oHE/Kxmw=;
        b=jELptrcnEyvuY8+El4dQXHXROKB8ewtArY1fyHvTAqCWNuCybXLAP5aXgdVml4y4Cq
         SRmI8g71EKi71mrv0uawpWPzPGX880a7U48VRPNc0MVSaJmpVM/Z7x6Ry79jxYf3z0cm
         y1ir7Afx4i1zJ8FVeG7BZUI2iDN5DxGAhfw+8ZRYZMruaGNA11erlbkHduCTEXVDqjsM
         p4cc+QPokhkn3cbl2lnw8mjlIJOY32HTW1DCyc1UPL5JQMS/Kk1qaX4Y4WlWWJZj4GsJ
         cETHDofkwend2oxKLsFIZTZ9apZdeJvK7y9ZF9QZVqDxrAdoGnXOQFMGtJJI405lsn2E
         VxeA==
X-Forwarded-Encrypted: i=1; AJvYcCWiFtjnz3erc1b7dMTb7/N6123LvgbV/NoH2JNxkYswelzoJpd9cJPEwzw3pslfKq9DLbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rZx/BxI2fiNJ0tkRMqV5QNzchOuRBewPfbZli4O9HE+nS22W
	w55VYdJADxsSzuKPmYtCXHix3x8cWFt2HaxHcNH3fo3GfJf1yY8Pv9KlTmzNcw==
X-Gm-Gg: AZuq6aLKZ1I80LcDhbu+sGg15/zUj35QHGFeCWRUFRwPpJ7wxphof+44K4cofUGF1tC
	LFo2Gp2sQfJagr0KyzXd/y0ittCEErgqsoBQdsKz+Qq5oL48jntlT89Kxh8LtFvtmbeMVVBfJlK
	z+R5TrK5wTea+gS0G6dYxNTYzCAkLUKkcTUjj3XiIa1ioI4/oHx+7OuP3p/e0M2IRiHJ03kulci
	gUErCo39Vo/1hKk4mOl1uktGVjvL4yXuFNxKA3gV1tHGH2Mc02k+/jeSL4xh05UGjG/x+Uq+Kel
	B7zuWBXqTnNKPO5PT7r8DYf3uNR74kvNZldfoIgVINM4xQHqr5aUK/1TT0ML1Uv7u4oE1sDLE4L
	hPGq2u6BiyRjhNGn7Tt/fRPMelS5AMOH3hucWtykUUxctCOCN10pRbklWiypNm397SUmfMMOec6
	+CbhnFMufUlHIfVGvDfsr2Ml3b6zVhHFRojI/OZFbFOgLn4WpmCG0ffoxL/EHxHuqASH7BvphNq
	sN/tGwQOZv8WJs=
X-Received: by 2002:a05:6214:1247:b0:880:5867:45b4 with SMTP id 6a1803df08f44-894cc7b9952mr92925456d6.13.1769637214740;
        Wed, 28 Jan 2026 13:53:34 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2889asm258472585a.27.2026.01.28.13.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:53:34 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1652AF4006C;
	Wed, 28 Jan 2026 16:53:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 Jan 2026 16:53:33 -0500
X-ME-Sender: <xms:XYV6aZ9z-QUvAGSHezMUHaFgptqOz8p1VjxHqW0DaB8Ff7R71d70cw>
    <xme:XYV6aTKqQ_J1Hvv4jkECTXfoBQLi0D7zHtroaelPik_EH1R1RN6t_x8EEryopcewD
    myJLUDdkPKjkf9X-uDk0PqRYXnNVbhp9SY7rG_rrQksmRnyPdjjrg>
X-ME-Received: <xmr:XYV6abyC1wZTJsOsYAivmPfFMdOpTePOUSi78KjN4kgnEhLJA-756fntmj6cLlLGqTKn8Rkw-ZhchELTp9S_mVAMATkrwfuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefgteffhfehjeegtdduieffudetfeehgfegudejudfhieefgfeigfevueduleduffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepgedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghr
    vhgvsegrnhgurhhoihgurdgtohhmpdhrtghpthhtohepthhkjhhoshesrghnughrohhiug
    drtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtmhhllhgrmhgrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghlihgtvg
    hrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:XYV6aeb6-lpxe5BmItSQ8TGwxwL3-m_BKM4W1H3Y-3cq0Mnn1AMx4g>
    <xmx:XYV6abse_Yxb9vsUFZBwhDupYtyUPOlCxBOaD1gVfEi9MRz6glZA8Q>
    <xmx:XYV6aQcIWTK4QFeE7DAYpbYjMW8gknH7DTvAtLJnamxd_XK-EUJTSw>
    <xmx:XYV6afbpQrkGgIIKfvZWuQ3WJziSIJzo_jziv4carR1ymlHvOg-Fdg>
    <xmx:XYV6aaHve5ck36TkQ4APwW2GO5o_n4kEHHShlf08OOo17DeEytfrbJd3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 16:53:32 -0500 (EST)
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
Subject: [RFC PATCH 0/7] Introduce HasField infrastructure
Date: Wed, 28 Jan 2026 13:53:23 -0800
Message-ID: <20260128215330.58410-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we have a few similar places where we use a `Has*` trait to
describe that a data structure has some types of field in it so that the
containing type can do something with it. There are also a `impl_has_*!`
macro to help implement the trait. While it's working, but it's less
ergonomic to me, especially considering the amount of the work we need
to do for something new (e.g. rcu_head).

Therefore here is the effort to unify them into a proc-macro based
solution. `Field` and `HasField` traits are introduced to generify the
"Has A" relationship, and a derive macro `#[derive(HasField)]` is also
added to support automatically implementing `HasField` trait.

This series convert a few users (Work, HrTimer) and introduce a new
`Field` type `RcuHead`. These improvements demonstrate how this
infrastructure can be used.

Some future work is still needed: using `HasField` for `DelayedWork` and
`ListLink` is still missing. Also it's possible to clean up `HasWork`
trait as well.

One known issue is that `#[derive(HasField)]` doesn't play alone with
`#[pin_data]` at the moment, for example:

    #[derive(HasField)]
    #[pin_data]
    struct Foo { .. }

works, but 

    #[pin_data]
    #[derive(HasField)]
    struct Foo { .. }

doesn't. Maybe it's by design or maybe something could be improved by
pin-init.


The patchset is based on today's rust/rust-next, top commit is:

	a7c013f77953 ('Merge patch series "refactor Rust proc macros with `syn`"')

Regards,
Boqun

Boqun Feng (7):
  rust: types: Introduce HasField trait and derive macro
  rust: time: hrtimer: Make `HasField` a super-trait of `HasHrTimer`
  rust: workqueue: Add HasField support for Work
  drivers: android: binder: Replace `impl_has_work!` with
    `#[derive(HasField)]`
  rust: sync: Completion: Replace `impl_has_work!` with
    `#[derive(HasField)]`
  rust: work: Remove `impl_has_work!`
  rust: sync: rcu: Introduce RcuHead

 drivers/android/binder/process.rs |   6 +-
 rust/kernel/field.rs              |  73 ++++++++++++++++++++
 rust/kernel/lib.rs                |   1 +
 rust/kernel/prelude.rs            |   4 +-
 rust/kernel/sync/completion.rs    |   8 +--
 rust/kernel/sync/rcu.rs           |  69 ++++++++++++++++++-
 rust/kernel/time/hrtimer.rs       |  70 ++++---------------
 rust/kernel/workqueue.rs          | 109 +++++++++++-------------------
 rust/macros/field.rs              |  85 +++++++++++++++++++++++
 rust/macros/lib.rs                |  11 +++
 10 files changed, 299 insertions(+), 137 deletions(-)
 create mode 100644 rust/kernel/field.rs
 create mode 100644 rust/macros/field.rs

-- 
2.50.1 (Apple Git-155)

