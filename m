Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91D38CFFA;
	Wed,  5 Aug 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942106; cv=none; b=kKjKTVWs+567bJ0Wwb9KegTvbuO8N1+AnPWQ89BewilAB/H67iv6inVAtqZLWfLn3aSqHTSDnTQS8HKcQ4yWlvmIOhWZmpf18PFT8RR6J4aTBwvXvE3F6wz2krbdOaYg1fYNpVoSer8b8pZ8DsQEGNtR0cNJbt0N/icL3YbD1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942106; c=relaxed/simple;
	bh=rCp+R3qtDaeP/d/2j8SxhMKLUNhNwI3f0ikDyy4GaBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgYeVrdOao4q11PlVXlOPRPNEZgG9YR4xZO+uWAjQEoTLjDeAzBHplDPNvxl0r6OYweRsBK3bkYfLHgEwQ5Z09F/rfKJ0S5mBaQVkj36oN8UTSEavFsBQ43nl63bkTbL5irro7zLhERNcP3kg9CaR9flB6IPHqksylFHidmnzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3TwAC4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3TwAC4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A25B1F00A3A;
	Wed,  5 Aug 2026 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942104;
	bh=mmTO2+HZnZJEiRo2DbVArdBrDXpT+adGtZsImi4HSIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n3TwAC4DF1kCUoiZ4ZdcTWLxgsnqw9nQI2b/0RpZta+m7SBf3oZHYlrlHDVdr4Y9e
	 W8DbQjLB3LrCXszjf6Eq8zrUzK85OzhC9MqAej/q5KNRMb/9XhdA2Se32S4jtitoVg
	 wj7858BayC1qEI8/1G+IVR4lvptVdJJxh19JokpQc/bZu6dkuePQzN3xIIIP5B8132
	 dGa+G8Nbbm9NByXJNtBcSzfrIDNSE5eRHL+10RB6VgsvkzCPxn1eqC1FYoTo7Zodw0
	 HdI2Ep5I/TcWIGMH8o5eTQbYBmepb/4LZYnnR1TMH1k3Ok14oW6iC1r+kvga0clLw2
	 B5Jr1h3O/wGIw==
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
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Burak Emir <bqe@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Mirko Adzic <adzicmirko97@gmail.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rcu@vger.kernel.org,
	Fiona Behrens <me@kloenk.dev>
Subject: [PATCH v9 1/5] rust: error: add remaining error codes
Date: Wed,  5 Aug 2026 16:59:43 +0200
Message-ID: <20260805145949.938505-3-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805145949.938505-2-phasta@kernel.org>
References: <20260805145949.938505-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Timur Tabi <ttabi@nvidia.com>

Add all of the remaining error codes from include/uapi/asm-generic/errno.h.

Previous updates to error.rs have been piecemeal -- adding single error
codes as needed.  Instead, we can avoid future problems by adding all
the remaining error code in one swoop.

EDEADLOCK and EWOULDBLOCK are intentionally left out: they are just
deprecated compatibility aliases of EDEADLK and EAGAIN, kept around for
non-Linux/POSIX code, and have no use in new kernel code.

Signed-off-by: Timur Tabi <ttabi@nvidia.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/error.rs | 105 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index a56ba6309594..f3096d7c73ac 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -30,6 +30,8 @@ macro_rules! declare_err {
         };
     }
 
+    // From include/uapi/asm-generic/errno-base.h
+
     declare_err!(EPERM, "Operation not permitted.");
     declare_err!(ENOENT, "No such file or directory.");
     declare_err!(ESRCH, "No such process.");
@@ -64,9 +66,112 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+
+    // From include/uapi/asm-generic/errno.h
+
+    declare_err!(EDEADLK, "Resource deadlock would occur.");
+    declare_err!(ENAMETOOLONG, "File name too long.");
+    declare_err!(ENOLCK, "No record locks available.");
+    declare_err!(ENOSYS, "Invalid system call number.");
+    declare_err!(ENOTEMPTY, "Directory not empty.");
+    declare_err!(ELOOP, "Too many symbolic links encountered.");
+    declare_err!(ENOMSG, "No message of desired type.");
+    declare_err!(EIDRM, "Identifier removed.");
+    declare_err!(ECHRNG, "Channel number out of range.");
+    declare_err!(EL2NSYNC, "Level 2 not synchronized.");
+    declare_err!(EL3HLT, "Level 3 halted.");
+    declare_err!(EL3RST, "Level 3 reset.");
+    declare_err!(ELNRNG, "Link number out of range.");
+    declare_err!(EUNATCH, "Protocol driver not attached.");
+    declare_err!(ENOCSI, "No CSI structure available.");
+    declare_err!(EL2HLT, "Level 2 halted.");
+    declare_err!(EBADE, "Invalid exchange.");
+    declare_err!(EBADR, "Invalid request descriptor.");
+    declare_err!(EXFULL, "Exchange full.");
+    declare_err!(ENOANO, "No anode.");
+    declare_err!(EBADRQC, "Invalid request code.");
+    declare_err!(EBADSLT, "Invalid slot.");
+    declare_err!(EBFONT, "Bad font file format.");
+    declare_err!(ENOSTR, "Device not a stream.");
+    declare_err!(ENODATA, "No data available.");
+    declare_err!(ETIME, "Timer expired.");
+    declare_err!(ENOSR, "Out of streams resources.");
+    declare_err!(ENONET, "Machine is not on the network.");
+    declare_err!(ENOPKG, "Package not installed.");
+    declare_err!(EREMOTE, "Object is remote.");
+    declare_err!(ENOLINK, "Link has been severed.");
+    declare_err!(EADV, "Advertise error.");
+    declare_err!(ESRMNT, "Srmount error.");
+    declare_err!(ECOMM, "Communication error on send.");
+    declare_err!(EPROTO, "Protocol error.");
+    declare_err!(EMULTIHOP, "Multihop attempted.");
+    declare_err!(EDOTDOT, "RFS specific error.");
+    declare_err!(EBADMSG, "Not a data message.");
+    declare_err!(EFSBADCRC, "Bad CRC detected.");
     declare_err!(EOVERFLOW, "Value too large for defined data type.");
+    declare_err!(ENOTUNIQ, "Name not unique on network.");
+    declare_err!(EBADFD, "File descriptor in bad state.");
+    declare_err!(EREMCHG, "Remote address changed.");
+    declare_err!(ELIBACC, "Can not access a needed shared library.");
+    declare_err!(ELIBBAD, "Accessing a corrupted shared library.");
+    declare_err!(ELIBSCN, ".lib section in a.out corrupted.");
+    declare_err!(ELIBMAX, "Attempting to link in too many shared libraries.");
+    declare_err!(ELIBEXEC, "Cannot exec a shared library directly.");
+    declare_err!(EILSEQ, "Illegal byte sequence.");
+    declare_err!(ERESTART, "Interrupted system call should be restarted.");
+    declare_err!(ESTRPIPE, "Streams pipe error.");
+    declare_err!(EUSERS, "Too many users.");
+    declare_err!(ENOTSOCK, "Socket operation on non-socket.");
+    declare_err!(EDESTADDRREQ, "Destination address required.");
     declare_err!(EMSGSIZE, "Message too long.");
+    declare_err!(EPROTOTYPE, "Protocol wrong type for socket.");
+    declare_err!(ENOPROTOOPT, "Protocol not available.");
+    declare_err!(EPROTONOSUPPORT, "Protocol not supported.");
+    declare_err!(ESOCKTNOSUPPORT, "Socket type not supported.");
+    declare_err!(EOPNOTSUPP, "Operation not supported on transport endpoint.");
+    declare_err!(EPFNOSUPPORT, "Protocol family not supported.");
+    declare_err!(EAFNOSUPPORT, "Address family not supported by protocol.");
+    declare_err!(EADDRINUSE, "Address already in use.");
+    declare_err!(EADDRNOTAVAIL, "Cannot assign requested address.");
+    declare_err!(ENETDOWN, "Network is down.");
+    declare_err!(ENETUNREACH, "Network is unreachable.");
+    declare_err!(ENETRESET, "Network dropped connection because of reset.");
+    declare_err!(ECONNABORTED, "Software caused connection abort.");
+    declare_err!(ECONNRESET, "Connection reset by peer.");
+    declare_err!(ENOBUFS, "No buffer space available.");
+    declare_err!(EISCONN, "Transport endpoint is already connected.");
+    declare_err!(ENOTCONN, "Transport endpoint is not connected.");
+    declare_err!(ESHUTDOWN, "Cannot send after transport endpoint shutdown.");
+    declare_err!(ETOOMANYREFS, "Too many references: cannot splice.");
     declare_err!(ETIMEDOUT, "Connection timed out.");
+    declare_err!(ECONNREFUSED, "Connection refused.");
+    declare_err!(EHOSTDOWN, "Host is down.");
+    declare_err!(EHOSTUNREACH, "No route to host.");
+    declare_err!(EALREADY, "Operation already in progress.");
+    declare_err!(EINPROGRESS, "Operation now in progress.");
+    declare_err!(ESTALE, "Stale file handle.");
+    declare_err!(EUCLEAN, "Structure needs cleaning.");
+    declare_err!(EFSCORRUPTED, "Filesystem is corrupted.");
+    declare_err!(ENOTNAM, "Not a XENIX named type file.");
+    declare_err!(ENAVAIL, "No XENIX semaphores available.");
+    declare_err!(EISNAM, "Is a named type file.");
+    declare_err!(EREMOTEIO, "Remote I/O error.");
+    declare_err!(EDQUOT, "Quota exceeded.");
+    declare_err!(ENOMEDIUM, "No medium found.");
+    declare_err!(EMEDIUMTYPE, "Wrong medium type.");
+    declare_err!(ECANCELED, "Operation Canceled.");
+    declare_err!(ENOKEY, "Required key not available.");
+    declare_err!(EKEYEXPIRED, "Key has expired.");
+    declare_err!(EKEYREVOKED, "Key has been revoked.");
+    declare_err!(EKEYREJECTED, "Key was rejected by service.");
+    declare_err!(EOWNERDEAD, "Owner died.");
+    declare_err!(ENOTRECOVERABLE, "State not recoverable.");
+    declare_err!(ERFKILL, "Operation not possible due to RF-kill.");
+    declare_err!(EHWPOISON, "Memory page has hardware error.");
+    declare_err!(EFTYPE, "Wrong file type for the intended operation.");
+
+    // From include/linux/errno.h
+
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-- 
2.55.0

