Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE883C584E
	for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204988; cv=none; b=PK/a9iNYNoehgHiNT5TGwEwvA9NQyQMymvkOjGgNsuSiI1pM3Q3jDbWzkkh4Tsvvt3lsgUlW5DGK5PeSN1b4hlPPZ3hdulXpkDU1tjewTHk+rfXVmThfqAIR6A63QhpDRFXDJAlPNWXEfm7BuV82UVh0akH8rTTjVytEyWgIncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204988; c=relaxed/simple;
	bh=j48XOqJXqdBy0t6+5bMRFjEtYFPZ1a1t8zNhjhq0jAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcrDLp1GjJFd1w3RML9CZ3KoHyU8zXVsem694csuj+/2bo3Iz2InHRnlUaLfhW+ZwiEYI53At9+Szr9bECwOl6rpFDOQCd5pwyTnTWGF98kQ8MmMNQO441CfKTpbQBV9cL+sief7w7/UZw6IpQV8s+5W7fByQ43kMvoOST+Hs+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jhRSUjLS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/R2XyAJ2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jhRSUjLS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/R2XyAJ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jhRSUjLS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/R2XyAJ2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jhRSUjLS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/R2XyAJ2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 359A575D0A;
	Tue, 23 Jun 2026 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782204984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98JU/eaXzv4ypgm1+tqmYP6YjnYiWrEb4y3aPJfCIvQ=;
	b=jhRSUjLSpT/Vd3QyMd9TiFUrmwrMmGv23HWnHILSNlB3vfPP+Dq8+OB0uM8Zpme1g3CvB4
	LGBzAs8EC8nTYWS3jpBZejcA4suIiOd3zeA+227ca3S+97xpCAmoNSYv0CPHF6lDRoKm1l
	77wDELrZALYKHHfZiM7xAJL6UY34GYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782204984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98JU/eaXzv4ypgm1+tqmYP6YjnYiWrEb4y3aPJfCIvQ=;
	b=/R2XyAJ2ZBwrSTygCV1fYX+tk12GzE5H6g9xFqQA3EzNzTzAFYKOGMoPnc40IFdarSyVeU
	j534ivrpuxGJTBCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jhRSUjLS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/R2XyAJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782204984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98JU/eaXzv4ypgm1+tqmYP6YjnYiWrEb4y3aPJfCIvQ=;
	b=jhRSUjLSpT/Vd3QyMd9TiFUrmwrMmGv23HWnHILSNlB3vfPP+Dq8+OB0uM8Zpme1g3CvB4
	LGBzAs8EC8nTYWS3jpBZejcA4suIiOd3zeA+227ca3S+97xpCAmoNSYv0CPHF6lDRoKm1l
	77wDELrZALYKHHfZiM7xAJL6UY34GYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782204984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98JU/eaXzv4ypgm1+tqmYP6YjnYiWrEb4y3aPJfCIvQ=;
	b=/R2XyAJ2ZBwrSTygCV1fYX+tk12GzE5H6g9xFqQA3EzNzTzAFYKOGMoPnc40IFdarSyVeU
	j534ivrpuxGJTBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B86779A8;
	Tue, 23 Jun 2026 08:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RpFLBDZKOmoCZgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 23 Jun 2026 08:56:22 +0000
Date: Tue, 23 Jun 2026 09:56:20 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lyude Paul <lyude@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for synchronize_rcu()
Message-ID: <ajpJmjTST-Hoxutb@pedro-suse.lan>
References: <20260622173250.411377-2-phasta@kernel.org>
 <20260622173250.411377-3-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622173250.411377-3-phasta@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 359A575D0A
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[33];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,zeniv.linux.org.uk,suse.cz,redhat.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLzijfi9nboexiud4o8afph5gt)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, Jun 22, 2026 at 07:32:49PM +0200, Philipp Stanner wrote:
> synchronize_rcu() is a frequently used C function which is always safe
> to be called.
> 
> Add a safe abstraction for synchronize_rcu().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  rust/kernel/sync/rcu.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b..0d438ef31766 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -50,3 +50,12 @@ fn drop(&mut self) {
>  pub fn read_lock() -> Guard {
>      Guard::new()
>  }
> +
> +/// Wait for one RCU grace period.
> +///
> +/// You typically do this to wait for everyone holding a [`Guard`].
> +#[inline]
> +pub fn synchronize_rcu() {
> +    // SAFETY: `synchronize_rcu()` is always safe to be called. It just waits for a grace period.

Commething randomly here (I know as much rust as the next not-knowing-rust-guy, sadly),
but synchronize_rcu() is not always safe to be called. You cannot call it if
you have the rcu read lock, or cannot sleep for any reason. I don't know if
you can encode these in the rust type system though.

-- 
Pedro
