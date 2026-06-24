Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8303D812C;
	Wed, 24 Jun 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313691; cv=none; b=kvVJ45Jqx0umgckv6g8JsdCfiVt3TB0Ud+Bc4X9vb1Gq2fDvrz501qH/KFnq9kXg3tcn70EvMaJLRBWOxu4wJdyVGYiOHzHMbJdQe7a5bw5QUj1qAI5XRMobdvaXsfJQuI0qxVx2Y4Sax+mJ8c/2KV10aKN/zwgC2mg9qE0dQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313691; c=relaxed/simple;
	bh=I/MuOgTCelPNrvwrjLZDioqlHxQ+Xeb3/chkS4scErs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IosW1fF4zEhRUiIqSkdc/7ifrVyrNgQZg6Jz6VvQ0O1SE+eX9nKqhD0GbzEShTj8V7HGRGzPl1JTO6btkYZ9DD2IMxFdvqpLDX/+r+TW7rnaFc/4PEz6JNuip4akQp+KC1SheQWMwS0JAvmahed2ORIWeI3weIGoESfHZv/Bu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFQj4WSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFQj4WSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D6D1F000E9;
	Wed, 24 Jun 2026 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782313690;
	bh=bVvjRCWWi7nb/kJnWI96Dow/D+Tkp3Sra2eyYrJTvcg=;
	h=From:To:Cc:Subject:Date;
	b=WFQj4WSffj4yWRpz8M8eA7t9AD2G2A7723jtUAauREByMrYt/6R9odIru64XzvWLJ
	 7KBldERyCwX9ZBQZbQdaCt11x/V2jCXpszE9LOsCu/dTSDbn9eYv/UJwrTgl3mS/99
	 PyEoewKyaQngOGWrVU9CtMkz0Nzr25t/GsAvna4NdynJar1ggM5eT8tiTQAmlCHIVL
	 QPZo4ui+CFtoavTw0sve/H5XckPVatMLuCff2W1q0igV/HklOwS0/tEm6UlDg0iwx8
	 7dBwgXiCp2tJCODvivemCjZF63rULI1GRN+ryBF5GfQySYA5Lh1hM1AJdag6/EHyIx
	 rYjzMnvgma+bQ==
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
Subject: [PATCH v3 0/3] Add and use abstraction for synchronize_rcu()
Date: Wed, 24 Jun 2026 17:07:01 +0200
Message-ID: <20260624150704.1504001-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v2:
  - Compromise docu for "RCU versus atomic context" a bit better
  - Add respective R-b's

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
 rust/kernel/sync/rcu.rs  | 16 ++++++++++++++++
 3 files changed, 28 insertions(+), 7 deletions(-)


base-commit: 43a393185e33e573a374c1d4f7ddf6481484ef8d
-- 
2.54.0

