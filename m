Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DA219FC;
	Mon, 22 Jun 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149591; cv=none; b=gET7uSpThrCad3HEjBPRiPLjoy/dG3AvE2wNIoRrh+g/n3yXxpdCSied9oITQg9mN284RVoIdd7xxkdgIiPLTvMfk6qdqz8FV7yD4to0fZm6OfIp8aEd4XX1ydKIInCC93iNMAbVaeFEUQrGdcJNqCTcea28TFQCfHsdKjq1BUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149591; c=relaxed/simple;
	bh=2RSCJf3PE4RjeRDiBGhiwSMUw+cfbaj/n6EzNv5ql6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RLxeuS9uPX3tspMgvHXYgY5Q1Fco9fWvUYkzGLWbKSDF2C/YgwIoGRBz0zl0iAWkKOM++VFYgCforbiwOjI6RnF+FjknsqcofXhUB158c4q2XkiE/bR2yZXYyznzdYBVGbwZ11a1ruBPheWymlawiU0JZ3sKsRFTAFbI5+1Q/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxfRfhSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxfRfhSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFD91F000E9;
	Mon, 22 Jun 2026 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149590;
	bh=v4zR4YrdpSR8YIBYVnPbXyaxkRq7E1pxRM+she0ITRU=;
	h=From:To:Cc:Subject:Date;
	b=GxfRfhSQoimVBtwEhOzrI2IKr5UMhDYroAI7GoatVt8r+l2pzPFI9cG7kjHThcksH
	 7EXpd3fbY8pMAkoV+zvR5GFEm2bCb3IFziLproTUpbfjRD3cy07nY/2mwqeRJ/8PFo
	 GrMyEDVA5nPTl3R9OwGprn9EI+NJEUT5+IXootnZslionKoiNrKXtMecCNBtKlVgxw
	 kOyL7WhaM2VDRe1F/0fJI3WsJBjP4gNe5V9ft4l8TUZsQ/VhifXMsZloT+bgbwhKrG
	 1C/MhqgHUD0JvduJXLn6Qpu5rbQiphqZk5IW+vNC8vvRBcRo8Q0h0ivA8DN7HI4CP0
	 WRMTLfQTbM52g==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Lyude Paul <lyude@redhat.com>,
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
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Philipp Stanner <phasta@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH v2 0/3] Add and use abstraction for synchronize_rcu()
Date: Mon, 22 Jun 2026 19:32:48 +0200
Message-ID: <20260622173250.411377-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
  - Vertically format imports. (Onur)
  - Make the new function #[inline]. (Alice)
  - Add Alice's R-b.

Philipp Stanner (3):
  rust: sync: Add abstraction for synchronize_rcu()
  rust: revocable: Use safe synchronize_rcu() abstraction
  rust: sync: Use safe synchronize_rcu() abstraction in poll

 rust/kernel/revocable.rs |  9 ++++++---
 rust/kernel/sync/poll.rs | 10 ++++++----
 rust/kernel/sync/rcu.rs  |  9 +++++++++
 3 files changed, 21 insertions(+), 7 deletions(-)


base-commit: 43a393185e33e573a374c1d4f7ddf6481484ef8d
-- 
2.54.0

