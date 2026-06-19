Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DE3128D7;
	Fri, 19 Jun 2026 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853508; cv=none; b=R0HgBi5/xd28bMMFVPiwcYdG84g0j35e6Kua2QTux6vvYUf/np1kp7TRsemP+bmECTDD7p7VaKcMVKhsi9F713KCe4etvN/meUQKn9K48sypBxTnDtm9Auatl7O+1h0n8Qj8atk3LMvA1CHpF8/ISHlKybMAQW9H0Y28vGio288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853508; c=relaxed/simple;
	bh=V0kTNq8A50vKzBROy0i4/aTI1JkLimxaHa6GvHf6Gvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBReJ51qfuy9xFYNQUTJn4wxNtozyn7ZbbmUYg0lzZtdeE/nQJqx7ZiDkQ3ctWzzVj1YxfrlfFolt5HoY3YRklPxpb7GXWjmg8ow367x8zRkWkq8aNOn7hAfqZPHPruelp/A4hl5tXcW/yCgTusg4F1Cd1gr/ZFLVEbG2WLPSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=hdZhyaMA; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="hdZhyaMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781853497; x=1782112697;
	bh=V0kTNq8A50vKzBROy0i4/aTI1JkLimxaHa6GvHf6Gvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hdZhyaMAgK4NSkxcBccp/2I9arJVt2y/l/x/TyVabglzYbsOptkxNLR7iC/2DCuzc
	 GpMW48zb5tNWXUAfdYbVsRJ8OfWa24D0Vtdfbi6AeleYrYy0CzcZV+AZKc8kwgi4EU
	 3tuNCqvYMoAWjAJcU/VWL2e00S+2U2kY+k4paei1V4hXPLuoOmpmZPB5+lPuOFG/tV
	 4x5HTyP+P+UqBI0naQT4vITK0a3WYT27hQ4NacieqJ7s/QZoOkMyWJot/E2vZ1WghZ
	 hUJt//WzSxnxwAoYxR2m/2Os6Zlq7Kr6aeLi9qpgVV2bSglIBN8w2szkoEy1/X8Cze
	 yesZ61pdTrpdw==
X-Pm-Submission-Id: 4ghTTH5J42z2ScmT
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Philipp Stanner <phasta@mailbox.org>
Cc: Philipp Stanner <phasta@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
Date: Fri, 19 Jun 2026 10:18:08 +0300
Message-ID: <20260619071809.12809-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <c449f26e2283a2df6d5240879f85bee1b2fd4c50.camel@mailbox.org>
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-4-phasta@kernel.org> <20260618181142.200117-1-work@onurozkan.dev> <c449f26e2283a2df6d5240879f85bee1b2fd4c50.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 08:55:44 +0200=0D
Philipp Stanner <phasta@mailbox.org> wrote:=0D
=0D
> On Thu, 2026-06-18 at 21:11 +0300, Onur =C3=96zkan wrote:=0D
> > On Thu, 18 Jun 2026 11:59:52 +0200=0D
> > Philipp Stanner <phasta@kernel.org> wrote:=0D
> > =0D
> > > We now have a safe wrapper for the foreign function synchronize_rcu()=
.=0D
> > > =0D
> > > Use it in poll.rs.=0D
> > > =0D
> > > Signed-off-by: Philipp Stanner <phasta@kernel.org>=0D
> > > ---=0D
> > > =C2=A0rust/kernel/sync/poll.rs | 6 ++----=0D
> > > =C2=A01 file changed, 2 insertions(+), 4 deletions(-)=0D
> > > =0D
> > > diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs=0D
> > > index 0ec985d560c8..401cf4d3f35f 100644=0D
> > > --- a/rust/kernel/sync/poll.rs=0D
> > > +++ b/rust/kernel/sync/poll.rs=0D
> > > @@ -8,7 +8,7 @@=0D
> > > =C2=A0=C2=A0=C2=A0=C2=A0 bindings,=0D
> > > =C2=A0=C2=A0=C2=A0=C2=A0 fs::File,=0D
> > > =C2=A0=C2=A0=C2=A0=C2=A0 prelude::*,=0D
> > > -=C2=A0=C2=A0=C2=A0 sync::{CondVar, LockClassKey},=0D
> > > +=C2=A0=C2=A0=C2=A0 sync::{rcu::synchronize_rcu, CondVar, LockClassKe=
y},=0D
> > =0D
> > nit: Missing vertical import. Same in the other module as well.=0D
> =0D
> Was already like that when I came here ;)=0D
> =0D
> But if it helps I can format it while I'm at it..=0D
=0D
Yeah there are still horizontal imports in certain modules and it's a perfe=
ct=0D
opportunity to fix them if we already making changes on them.=0D
=0D
- Onur=0D
=0D
> =0D
> =0D
> P.=0D
