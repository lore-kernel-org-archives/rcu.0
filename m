Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC01531C1
	for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643225; cv=none; b=OqvJUca5SuN5qtZS5HBdzPC1Cm8E/oHZZ7bkefrl4nNYwMYpE7jUoiPatRH8M802S8DHGO4sdhvy9k0g2HDEXS6/MfJqLuLU1I+6x4qrof2COt8jvS2VYK27XymIPl3d5t+RjdE4EPBrqvrPKguy3lbxuB2UyGdQEyBvQ3hkhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643225; c=relaxed/simple;
	bh=1d8hvFb5TqW+gQq4qtYvC+fv837UPEdBxL2Hk07VcJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTFOlGS1FeWjyB0D0OzAteLR72l+07HIf6g1V8zCz2T0rZF6yLhzOVUW2yJpU0fDwO/qHd5XkGEKqxNYdehVsvBwvWqSkG9qwOPS/R3B+Xw+JPB3oco6aIKwPqv3gvPscyRr925wEfKG4RItvhjS1cMo2TKYuMz0vav65W0MSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2qZ/vNL; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2qZ/vNL"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4096aab5521so270354fac.3
        for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 15:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643223; x=1770248023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+paZfars3KKP1JZVhG7KRu0fZBv7UeCEE9k0P4oMOM4=;
        b=g2qZ/vNLOKelNtFkmMBQkDsmIziyOKnp45FPtn4K6TUnPlBp4+FlAkfwqgdXB4g+Qk
         mTrTsStrXlEiv7smqbwxMBFG18QSa9zbfjoMgD0lGCmwKxcvVKIlLzfscHfTaCerbkDR
         m2TZtIcqWtuPEjRUI25ZmYV5/Ezaoq/e63TCU6mFIT7ZxznvDwdglxzFPPQQHTW+mV5B
         cJvFnu2bk/DDUZX1fqLo/X/yb1lVnFV0L4/ZUPjzu/prIrX+mzbH9wRPT8MqRZAdIUjz
         gJ5q3ebD/IuDzHabpaKBXwclGRctJfgR1PHU9Qu3zPg9f7RRjNTMYwNFNRqpFDxSAYhV
         IN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643223; x=1770248023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+paZfars3KKP1JZVhG7KRu0fZBv7UeCEE9k0P4oMOM4=;
        b=B6b53KBWNJeyvcW9r9p29cWCN+7K6lWAPFDLJ4kZgml4IVUV56Xfrn+B8emwDAG610
         tynCt3uVbodkC5edhCbmpbIKSMZzwDCFZXuyWFACRu1W4BxhZX+4jDQLGc6/Zc5KBWqG
         3lEAH0M6DIE0Ib/NNWF3QkJLf5sTYLyCsIMzs8tO8tFb+p43uaYydqEJ9lEMpmd3XioB
         cy+th4TWNx1pDowtsBTRb2ge6ycdhjh/bZt1anpWdE/io4z3HaZ22SXW7M67lCwO4EsO
         VVwSDiA43AznMnLbgm+Sgd6I9LvjAGgNsjDMraw3h6unlzGUvqkX3LqwR0J/dIQwhlOi
         wDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU3N8TwXsebPkc/+VHyPr5LryuQcUXNhpa1YsCo8kHlh1aqblmM9MRKUNcjjzRJgd/Dkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPupXwWAo9o2xH5oIYbP6XWlmx5CxY7y1lsEsH7J9Uv54m5px
	at/ukMmxyJr1lMc2oaQOTfb8mYtrs9qPzbfBJfOzmkES1dHvxkOsEsMcD/MKXQ==
X-Gm-Gg: AZuq6aIYVdoPPdpqVacRXhUWWVyxRv1vwJXCghR5GpSNwd3MCejUZfk0sijcZKV5h9u
	n9MWvnsoMLQvezIJcw2MRUhl7LSIGkK7K/Wke097SxreE49m4axnchXlui2IgraR0s63jV7F6By
	yaphEZcSl8PTz32C3c8fP2SwFjQFcDoBNu8XQrANSxfdfBzKKHpkXKqCZUaxrA/4RaNPo9ou9w+
	adl8phaMJfBiP0Evr5AvlUNgJVWA2IYTDhaxi2xgo8EwAUPqZxF2h5fGObZmmy5Y9YKxeI6XSC4
	0RRkO+CCbyCsyDlFtxBqo5lmkUSarrIWZ71fJkqlq0AHutKkhU5Dgukz/0lie5uTJYSx/KMVlAd
	x6D9C/89OjyFo9WhGF9ZVfDj6xnjrh07vNBHGzcQ5u5Xx0Zn1eNgWpnANJ07KGNefkZGR6ZEA1N
	6Q18zShXyCdhbvnmnttZtfaEV7RkVHk6IW8blvbzQzWRYx4fR1GgeB083agOi4gVEjMpVNXndRO
	vPZ3KwTNx5NN30=
X-Received: by 2002:ad4:5cea:0:b0:894:7e6f:f92c with SMTP id 6a1803df08f44-894cc94b68cmr93585776d6.58.1769637220835;
        Wed, 28 Jan 2026 13:53:40 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d40139sm259339985a.37.2026.01.28.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:53:40 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 86AD0F4006D;
	Wed, 28 Jan 2026 16:53:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 28 Jan 2026 16:53:39 -0500
X-ME-Sender: <xms:Y4V6aRWeCI0545xWhVYC0QgKyXzbKjvWE1I1YD2FIIqZq_MGCjG33Q>
    <xme:Y4V6aXDCpoxRqfrFdHE-iQshoxUaPhl53sOmzf6PiObqsrOe5k7TnX7_fNwcdGFkn
    FNxFUEqQ3B6SBimHsoQhlmxadVkDHhXi7Jebh7trj0F3tXs6Ard>
X-ME-Received: <xmr:Y4V6aSKJ-OcEbtooGX_Z8XUV-DdD06DZ6JSe8SY8NMDxX0xbhywPOpgCBsVRJFBtSyaLFAWS0xVvsJi5EsqwuVje2OjHIVyv>
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
X-ME-Proxy: <xmx:Y4V6aVRY0js76Ab9iL-NAj3Dfa1r7hjlbos2qnRLH7T0VmNEHVmjJA>
    <xmx:Y4V6aZG6CEzclz06rKczw3viDjSe-W3PBTb0hCEgQCb5yTSVjUOIpg>
    <xmx:Y4V6aSWmlDWEyrZ-ahv2PYB3imIEuL2qZLFuTgEHL37M0RMzw5gsQA>
    <xmx:Y4V6abwwXHEnFm0HoBi71xxD-GDCpawyO-UhYtElFFZt-pL1IXPFyA>
    <xmx:Y4V6ae_1XKKeLD42DLKV3RMY_T8nxl5ttewqSvFjJjH0TtnJXTlJD9Zc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 16:53:38 -0500 (EST)
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
Subject: [RFC PATCH 4/7] drivers: android: binder: Replace `impl_has_work!` with `#[derive(HasField)]`
Date: Wed, 28 Jan 2026 13:53:27 -0800
Message-ID: <20260128215330.58410-5-boqun.feng@gmail.com>
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

`#[derive(HasField)]` offers less code and better ergonomic for defining
a struct with a Work in it. Hence replace the current usage of
`impl_has_work!()`.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/android/binder/process.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 132055b4790f..2a2510e3a0cb 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -423,6 +423,7 @@ fn new() -> Self {
 /// Strictly speaking, there can be multiple of these per process. There is one for each binder fd
 /// that a process has opened, so processes using several binder contexts have several `Process`
 /// objects. This ensures that the contexts are fully separated.
+#[derive(HasField)]
 #[pin_data]
 pub(crate) struct Process {
     pub(crate) ctx: Arc<Context>,
@@ -451,6 +452,7 @@ pub(crate) struct Process {
 
     // Work node for deferred work item.
     #[pin]
+    #[field]
     defer_work: Work<Process>,
 
     // Links for process list in Context.
@@ -460,10 +462,6 @@ pub(crate) struct Process {
     pub(crate) stats: BinderStats,
 }
 
-kernel::impl_has_work! {
-    impl HasWork<Process> for Process { self.defer_work }
-}
-
 kernel::list::impl_list_arc_safe! {
     impl ListArcSafe<0> for Process { untracked; }
 }
-- 
2.50.1 (Apple Git-155)

