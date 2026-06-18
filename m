Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CDE33A9DA;
	Thu, 18 Jun 2026 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776864; cv=none; b=kzfrrbrWSnfVMwORRyxqr2qnM7VL8MnEZWeuwfVbOVErHuHuoq0asLkZNe9wqZxhSXkwpNMwK1M9zJh+lfbF8XNREotj4ELOeprKp/T26EvYpKcon/Nhx8qU6yybyO79iHCGPBZR24XNP2MfI1w2wDKOvsZHTcnl3XQCY0OOlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776864; c=relaxed/simple;
	bh=E7S1fQzcP2I2A1AQY6o5E+7hsqHhXDbi10ke0u2w5wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szPbcwbwJuM6xkVa2TBMFj4nqZr68xrozGmwLaMFnbLnJwQPG3oGojaZ3W8QQfVttNMgczi08t5gZYwYgENDNh0u4aapFH/n41A+3uUG/9bxYmsagtvZM3v6sjkJrbkJLJdBZ9htqSM7aVPwyrklilWA2hnR8RTpNAei0DFE/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqMaJQkR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqMaJQkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055B11F000E9;
	Thu, 18 Jun 2026 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776863;
	bh=MmcbLodhRJVgyyIVTS06NmgSyFYXSZhBdNpRmqsOMdc=;
	h=From:To:Cc:Subject:Date;
	b=IqMaJQkRi6GQBGVGKzRMkiE+gD0Cut6gKG2IAxByx/4xnKbuUdJ2KxqgtPP9Tg+ec
	 ZqhP9vv5dtWMXiDz583Lo2hKTbdNybWSFkvVS8Bguu7tQSXX8+kSgaRhHxtfrvcHbj
	 nlcolojixkT1SdDvoo7ftK4DYdoLqt6MWOSUsO12vDxoeeA64Tg4TzgNEape0Be18A
	 d4hwD+Is9HqchTRsgZzH1w+HoCU9mKAOK1MxXjnoY4NHJPRExNmzS8JK964Rto79A0
	 LDeZlE3JlOsFFGfYdmIjxvMPi/fJWbvptgqbTXrd+VXPfdQfI++yzrLiSsWLs8bUyF
	 DrB5i52Wkom9g==
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
	Philipp Stanner <phasta@kernel.org>,
	Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH 0/3] Add and use abstraction for synchronize_rcu()
Date: Thu, 18 Jun 2026 11:59:49 +0200
Message-ID: <20260618095952.3687099-1-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just compile tested this series, but I did use commit 1 in my DmaFence
and it worked well.

Philipp Stanner (3):
  rust: sync: Add abstraction for synchronize_rcu()
  rust: revocable: Use safe synchronize_rcu() abstraction
  rust: sync: Use safe synchronize_rcu() abstraction in poll

 rust/kernel/revocable.rs | 5 ++---
 rust/kernel/sync/poll.rs | 6 ++----
 rust/kernel/sync/rcu.rs  | 8 ++++++++
 3 files changed, 12 insertions(+), 7 deletions(-)


base-commit: 43a393185e33e573a374c1d4f7ddf6481484ef8d
-- 
2.54.0

