Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580234028B;
	Mon, 22 Jun 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149829; cv=none; b=corEoooqlY0roPnGj0XCw8puzeUfmx6iNnaxYT9XoqyEATL1YWUXaRt3xiaCXFr/wlZvU/P6CJx8hYH4ZiVQXf6/VglEdpBdia5On8rA9XWHMCp39Qmx7q2Z6IdegQMqUPPTfpimImWLZj+N1zULwTKOiaENFsBoJMLE4vbdn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149829; c=relaxed/simple;
	bh=4ltsw82Pt1YDANpneJ1yijvoWJCitYDFaHVz307d9xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieHtmT/gFYA8ouYuutVQd2OSXXO1SRa9QQag5OZWpIu8Y7aB3R+VjpmkSdkmLe+RID47yjmijtdBjZ2OdMjiq/D8Jd49vkx3cvvRF8ThZn4RXIjwmEv3u3MoEN8AwPOA+CFFbY8Ea/3yUECLbeEWQPHqkBqbDgqXQlrvsQDTnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=J9o1o25V; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="J9o1o25V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1782149818; x=1782409018;
	bh=u8MdlkzvcCfAjnAo8dHkVy8AZAP7IufjjrnBhUqu0w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=J9o1o25VLxpBir90HfJOIeMnHFq8kO94EnpOfavqElBMfeiHtyaD1vKtCVEPns2cF
	 9/t/VXhdBf4B3rPhf5D5BNVJhserCCyyHfxjwBdMjQL6OjA5cJ3ry15UTh6uwBfiou
	 k6XwXHedEra9KFb1ODbogayX8ZcskcFmZ8VDWhmTyszedeubzKmP9Beq5ZISZ5q+2m
	 rltuOT6ehD07uH214FpmQ6bgwPTQQRTmgjHFia4QNzmYajFE5Vgrb467zVHdt0VF9+
	 K0aeF69djyU+rDC/wx5mMBdlGiAEWyAbKWGolOfS6CtUGqFEUHSsZHcfRBV/TQysbY
	 4ayAD5/9E81iA==
X-Pm-Submission-Id: 4gkb3k5MJKz1DFTD
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
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
	rcu@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v2 0/3] Add and use abstraction for synchronize_rcu()
Date: Mon, 22 Jun 2026 20:36:44 +0300
Message-ID: <20260622173649.19858-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260622173250.411377-2-phasta@kernel.org>
References: <20260622173250.411377-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jun 2026 19:32:48 +0200=0D
Philipp Stanner <phasta@kernel.org> wrote:=0D
=0D
> Changes since v1:=0D
>   - Vertically format imports. (Onur)=0D
>   - Make the new function #[inline]. (Alice)=0D
>   - Add Alice's R-b.=0D
> =0D
> Philipp Stanner (3):=0D
>   rust: sync: Add abstraction for synchronize_rcu()=0D
>   rust: revocable: Use safe synchronize_rcu() abstraction=0D
>   rust: sync: Use safe synchronize_rcu() abstraction in poll=0D
> =0D
>  rust/kernel/revocable.rs |  9 ++++++---=0D
>  rust/kernel/sync/poll.rs | 10 ++++++----=0D
>  rust/kernel/sync/rcu.rs  |  9 +++++++++=0D
>  3 files changed, 21 insertions(+), 7 deletions(-)=0D
> =0D
> =0D
> base-commit: 43a393185e33e573a374c1d4f7ddf6481484ef8d=0D
> -- =0D
> 2.54.0=0D
> =0D
=0D
For the whole series:=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
